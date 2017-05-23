require 'byebug'
require 'openSSL'
require 'json'
require './test_case'
require 'dotenv'
require 'to_bool'

describe "Pushing Triggers " do
  # Starting the resquest
  before(:all) do
   if ENV['HAWKULAR_BODY'].to_bool == true
   body = JSON.parse(File.read('autoresolve-trigger.json')).to_json
   elsif
   body = ""
   end
    
    parameters = {:name =>"Pushing Triggers", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/import/all", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool, :http_method=> 'POST',
      :hawkular_tenant=> ENV['HAWKULAR_TENANT'], :content_type => 'application/json',
      :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' ,
      :body => body }
      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
  end

  it "should be 200 code of HTTP Response if body is not empty and 400 if body is empty" do
    if ENV['HAWKULAR_BODY'].to_bool == true
      expect(@response.code).to  eq("200")
    elsif
      expect(@response.code).to eq("400")
     end
  end
end
