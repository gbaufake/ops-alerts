require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
require './test_case'

describe "Delete an Event" do

  before(:each) do
    @parameters = {"name" =>"Delete an Event", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts/events/delete", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'PUT', :body => ""}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
        "content-type" => 'application/json',
         "authorization" => ENV['HAWKULAR_TOKEN'],
         "cache-control" => 'no-cache'}
  end

  it "Correctly Deletion of events should be 200 code for HTTP Response" do
   events_tags = "nodename|vm-48-124.eng.lab.tlv.redhat.com"
   @parameters["hawkular-url"] = @parameters["hawkular-url"] + "?tags=#{events_tags}"
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

end
