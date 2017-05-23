require 'byebug'
require 'openSSL'
require 'json'
require './test_case'
require 'dotenv'
require 'to_bool'

describe "Pushing Triggers " do
  # Starting the resquest
  before(:all) do
    @parameters = {:name =>"Pushing Triggers", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/import/all", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool, :http_method=> 'POST',
      :hawkular_tenant=> ENV['HAWKULAR_TENANT'], :content_type => 'application/json',
      :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' }
   end

  it "HTTP Response should be 200 if body is not empty" do
    @parameters[:body] = JSON.parse(File.read('autoresolve-trigger.json')).to_json
    @test_case = TestCase.new(@parameters)
    @response = @test_case.peform_request
    expect(@response.code).to  eq("200")
  end

 it "HTTP Response should be 400 if body is empty" do
    @parameters[:body] = ''
    @test_case = TestCase.new(@parameters)
    @response = @test_case.peform_request
    expect(@response.code).to  eq("400")
 end
end
