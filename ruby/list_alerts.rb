# curl -k -s \
#     -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
#     -H "Authorization: Bearer $HAWKULAR_TOKEN" \
#     https://$HAWKULAR_HOST/hawkular/alerts/?start=0 | jq .

require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load  './test_case.rb'


describe "List Alerts " do

  # Starting Request
  before(:each) do

    @parameters = {"name" =>"List Alerts", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'GET', :body => ""}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
        "content-type" => 'application/json',
         "authorization" => ENV['HAWKULAR_TOKEN'],
         "cache-control" => 'no-cache'}

    end

  it "HTTP Response should be 200 if the request is correct" do
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

  it "HTTP Response should be 200 if the request has a known parameter" do
   @parameters["hawkular-url"] = @parameters["hawkular-url"] + "?startTime=0"
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

  it "HTTP Response should be 400 if the request has an unknown parameter" do
   @parameters["hawkular-url"] = @parameters["hawkular-url"] + "?startTyme=0"
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("400")
  end

end
