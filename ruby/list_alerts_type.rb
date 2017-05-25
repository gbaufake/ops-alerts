require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'


describe "List Alerts by Type" do

  # Starting Request
  before(:each) do

    @parameters = {"hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts?tags=type|*", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method" => 'GET', :body => ""}

    @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
      "content-type" => 'application/json',
       "authorization" => ENV['HAWKULAR_TOKEN'],
       "cache-control" => 'no-cache'}
    end

  it "HTTP Response should be 200" do
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end
end
