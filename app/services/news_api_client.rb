# frozen_string_literal: true

class NewsApiClient
  attr_reader :conn

  NEWS_API_URL = 'https://newsapi.org/v2/'

  def initialize
    @conn = Faraday.new(url: NEWS_API_URL, params: { 'apiKey' => ENV.fetch('NEWS_API_API_KEY') })
  end

  def fetch_related_articles(query: '', from: Time.now.yesterday.strftime('%F'), sort_by: 'popularity')
    response = conn.get('everything') do |req|
      req.params['q'] = query
      req.params['from'] = from
      req.params['sortBy'] = sort_by
    end

    JSON.parse(response.body)['articles'].try(:first, 5) || []
  end
end
