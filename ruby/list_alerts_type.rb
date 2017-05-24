require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'


describe "List Alerts by Type" do

  # Starting Request
  before(:all) do

    parameters = {:name =>"List Alerts by Type", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts?tags=type|*", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'GET', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ""}
      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
    end

  it "should be 200 code of HTTP Response" do
    expect(@response.code).to  eq("200")
  end
end
