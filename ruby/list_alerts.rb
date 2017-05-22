# curl -k -s \
#     -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
#     -H "Authorization: Bearer $HAWKULAR_TOKEN" \
#     https://$HAWKULAR_HOST/hawkular/alerts/?start=0 | jq .

require 'byebug'
require 'dotenv'
require 'to_bool'
require 'json'
require './test_case'


describe "List Alerts " do

  # Starting Request
  before(:all) do

    parameters = {:name =>"List Alerts", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/?start=0", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'GET', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ""}
      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
    end

  it "should be 200 code of HTTP Response" do
    expect(@response.code).to  eq("200")
  end

end
