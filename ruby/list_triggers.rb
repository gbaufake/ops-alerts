require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
load './test_case.rb'

describe "List Triggers " do

  # Starting Request
  before(:all) do
    parameters = {:name =>"Listing Triggers", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/export", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'GET', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ''}
      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
    end

  it "should be 200 code of HTTP Response" do
    expect(@response.code).to  eq("200")
  end

  it "should be an non empty response body " do
    expect(@response.body).not_to be_empty
  end


end
