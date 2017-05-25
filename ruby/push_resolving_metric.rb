# NOW=$(date +%s000)
# curl -s -k  \
#   -H "Hawkular-Tenant: ${HAWKULAR_TENANT}"       \
#   -H "Authorization: Bearer ${HAWKULAR_TOKEN}" \
#   -H "Content-Type: application/json" \
#   -X POST \
#   -d "[{'timestamp': ${NOW}, 'value': 3}]" \
#   https://${HAWKULAR_HOST}/hawkular/metrics/gauges/data_x/raw


require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'


describe "Push Resolving Metrics " do

  # Starting Request
  before(:each) do

    @parameters = {"name" =>"Push Resolving Metrics", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/metrics/gauges/data_x/raw", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'POST'}
      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
          "content-type" => 'application/json', "authorization" => ENV['HAWKULAR_TOKEN'],
           "cache-control" => 'no-cache'}

      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
    end

  i  it "should be 200 code of HTTP Response when it sends a metric with value 3 (Resolving Metric) " do
      value = 3
      @parameters["body"]= "[{'timestamp': #{Time.now.to_i}, 'value': #{value} }]"
      test_case = TestCase.new(@parameters, @headers)
      response = test_case.peform_request
      expect(response.code).to  eq("200")
    end

end
