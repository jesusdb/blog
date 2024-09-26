# Titan Blog

This application was made to fulfill technical requirements. It is a Ruby on Rails web app that allows users to create articles, comment these articles and delete them. There is a notification service and an external News API service to retrieve related articles.

## Prerequisites

You need the following tools installed already in order to run this system:

- Ruby 3.1.2
- Bundler 2.3.25
- Git
- PostgreSQL 16.4
- Redis 7.4.0

In case you don't want to install Postgres and Redis, or those specific versions, you can alternatively use Docker.

## Getting Started

If you have Docker installed and don't want to install Postgres and Redis, you can use the following command to configure Postgres in your local machine:

    $ docker container run --publish 5432:5432 -e POSTGRES_PASSWORD=<postgres_password> -v postgres-data:/var/lib/postgresql/data postgres

And then, for Redis:

    $ docker container run --publish 6379:6379 -v redis-data:/data redis

### Configuration

Create a file named `.env` on the root of the project and add the following environment variables:
```
POSTGRES_HOST=localhost
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=<postgres_password>
NEWS_API_API_KEY=<news_api_api_key>
```
#### PostgreSQL
Please update the file `config/database.yml` in case you want to have a different configuration.

#### News API
You need to register on https://newsapi.org to get the API key to be able to fetch the external related articles.

### Installation

At this point you need to have Postgres server installed already, or the command below will fail, unless you've run the command above using Docker. Go to the root folder (`blog/`) and run:

    $ bundle install

Then create the databases:

    $ bundle exec rails db:create

And execute the migrations:

    $ bundle exec rails db:migrate

To create a user and some articles with tags, seed the database:

    $ bundle exec rails db:seed

### Start Server

First, you have to start the Rails server:

    $ bundle exec rails s

### Tests

The testing tool used for this application is RSpec.

To run all the tests, execute in the root folder:

    $ bundle exec rspec

This will automatically run all the tests written inside `spec/`. You can run it for a specific test file:

    $ bundle exec rspec spec/models/article_spec.rb

### Code Coverage

To check the code coverage of this project, simply run all the tests as mentioned in the previous section and then you could find the file `coverage/index.html` that will display the percentage and more details about the lines covered/uncovered.
