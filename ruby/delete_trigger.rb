require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
require './test_case'

describe "Delete a Trigger" do

  before(:each) do
    @parameters = {"name" =>"Delete a Trigger", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts/triggers/", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'PUT', :body => ""}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
        "content-type" => 'application/json',
         "authorization" => ENV['HAWKULAR_TOKEN'],
         "cache-control" => 'no-cache'}
  end

  it "Correctly Deletion of Triggers should be 200 code for HTTP Response" do
   trigger_tag = "ops-example"
   @parameters["hawkular-url"] = @parameters["hawkular-url"] + trigger_tag
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

end
