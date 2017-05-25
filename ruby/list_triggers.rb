require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'

describe "List Triggers " do

  # Starting Request
  before(:each) do
    @parameters = {"name" =>"Listing Triggers", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts/export", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'GET', :body => ''}

    @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
        "content-type" => 'application/json',
         "authorization" => ENV['HAWKULAR_TOKEN'],
         "cache-control" => 'no-cache'}


    end

  it "HTTP Response should be 200 on Listing Triggers" do
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

  it "HTTP Response Body should be not Empty after sucessfull request " do
    test_case = TestCase.new(@parameters, @headers)
    response = test_case.peform_request
    expect(response.body).not_to be_empty
  end


end
