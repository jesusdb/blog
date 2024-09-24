# frozen_string_literal: true

shared_context 'mock News API request' do
  # Test adapter
  stub = Faraday::Adapter::Test::Stubs.new
  # Instantiate a connection that uses the test adapter
  # conn = Faraday.new { |builder| builder.adapter(:test, stub) }
  let(:conn) { Faraday.new { |builder| builder.adapter(:test, stub) } }

  # Define any number of mock network requests on the test adapter, which yields an array of three elements:
  #   1. HTTP response code
  #   2. Hash of HTTP response headers
  #   3. String of HTTP response body
  stub.get('everything') do
    [
      200,
      { 'Content-Type': 'application/json' },
      '{"foo": "bar"}'
    ]
  end
end
