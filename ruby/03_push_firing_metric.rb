require 'byebug'
require 'dotenv'
require 'to_bool'
require 'JSON'
require './test_case'


# NOW=$(date +%s000)
# curl -s -k  \
#   -H "Hawkular-Tenant: ${HAWKULAR_TENANT}"       \
#   -H "Authorization: Bearer ${HAWKULAR_TOKEN}" \
#   -H "Content-Type: application/json" \
#   -X POST \
#   -d "[{'timestamp': ${NOW}, 'value': 7}]" \
#   https://${HAWKULAR_HOST}/hawkular/metrics/gauges/data_x/raw


describe "Push Fire Metrics " do

  # Starting Request
  before(:all) do
    value = 7
    body = "[{'timestamp': #{Time.now.to_i}, 'value': #{value} }]"

    parameters = {:name =>"Push Fire Metrics", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/metrics/gauges/data_x/raw", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'POST', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => body}
      @test_case = TestCase.new(parameters)
      @response = @test_case.peform_request
    end

  it "should be 200 code of HTTP Response" do
    expect(@response.code).to  eq("200")
  end

end
