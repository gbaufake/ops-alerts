require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'


describe "Show Metrics " do

  # Starting Request
  before(:each) do

    @parameters = {"name" =>"Show Metrics", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/metrics/gauges/data_x/raw?start=0", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'GET', :body => ""}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
          "content-type" => 'application/json',
           "authorization" => ENV['HAWKULAR_TOKEN'],
           "cache-control" => 'no-cache'}

    end

  it "should be 200 code of HTTP Response when the request is correct" do
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(@response.code).to  eq("200")
  end
end
