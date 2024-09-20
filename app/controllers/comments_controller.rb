# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_article, only: %i[ index new create ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    authorize @comment
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params.merge({ article_id: @article.id, user_id: current_user.id }))

    respond_to do |format|
      if @comment.save
        NotificationService.new(
          notification: Notification.create!(
            message: "#{current_user.email} commented your article \"#{@article.title}\".",
            user: current_user, recipient: @article.user, notifiable_type: 'Article', notifiable_id: @article.id
          )
        ).send_notification

        format.html { redirect_to @article, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render 'articles/show', comment: @comment, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    authorize @comment

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @article, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    authorize @comment

    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @comment.article, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
