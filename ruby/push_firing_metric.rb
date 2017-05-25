require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load  './test_case.rb'


describe "Push Fire Metrics " do

  # Starting Request
  before(:each) do

    @parameters = {"name" =>"Push Fire Metrics", "hawkular-environment"=> ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/metrics/gauges/data_x/raw", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'POST'}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
          "content-type" => 'application/json', "authorization" => ENV['HAWKULAR_TOKEN'],
           "cache-control" => 'no-cache'}
    end

  it "should be 200 code of HTTP Response when it sends a metric with value 7 (Firing metric) " do
    value = 7
    @parameters["body"]= "[{'timestamp': #{Time.now.to_i}, 'value': #{value} }]"
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

end
