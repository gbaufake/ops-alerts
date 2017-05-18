# # Trigger
# curl -k -s \
#     -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
#     -H "Authorization: Bearer $HAWKULAR_TOKEN" \
#     -X DELETE \
#     https://$HAWKULAR_HOST/hawkular/alerts/triggers/ops-example| jq .
#
# # Alerts
# curl -k -s \
#     -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
#     -H "Authorization: Bearer $HAWKULAR_TOKEN" \
#     -X PUT \
#     https://$HAWKULAR_HOST/hawkular/alerts/delete?tags="nodename|vm-48-124.eng.lab.tlv.redhat.com"
#
# # events
# curl -k -s \
#     -H "Hawkular-Tenant: $HAWKULAR_TENANT" \
#     -H "Authorization: Bearer $HAWKULAR_TOKEN" \
#     -X PUT \
#     https://$HAWKULAR_HOST/hawkular/alerts/events/delete?tags="nodename|vm-48-124.eng.lab.tlv.redhat.com"

require 'byebug'
require 'dotenv'
require 'to_bool'
require 'JSON'
require './test_case'

describe "Cleanup" do

  # Starting Requests
  before(:all) do
    # Triggers
     triggers_parameters = {:name =>"Cleanup Triggers", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/triggers/ops-example", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'DELETE', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ""}

      @triggers_test_case = TestCase.new(triggers_parameters)
      @triggers_response = @triggers_test_case.peform_request

    # Alerts
    alerts_tags = "nodename|vm-48-124.eng.lab.tlv.redhat.com"
    alerts_parameters = {:name =>"Cleanup Alerts", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
      :hawkular_url => "hawkular/alerts/delete?tags=#{alerts_tags}", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
      :http_method=> 'PUT', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ""}
      @alerts_test_case = TestCase.new(alerts_parameters)
      @alerts_response = @alerts_test_case.peform_request

      # Events
      events_tags = "nodename|vm-48-124.eng.lab.tlv.redhat.com"
      events_parameters = {:name =>"Cleanup Alerts", :hawkular_envirorment => ENV['HAWKULAR_ENVIRONMENT'],
        :hawkular_url => "hawkular/alerts/events/delete?tags=#{alerts_tags}", :ssl=> ENV['HAWKULAR_USE_SSL'].to_bool,
        :http_method=> 'PUT', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
        :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :no_cache => 'no-cache' , :body => ""}
        @events_test_case = TestCase.new(events_parameters)
        @events_response = @events_test_case.peform_request

 end
  it "should be 200 code for HTTP Response on Delete Trigger" do
   byebug
    expect(@triggers_response.code).to eq("200")
  end

  it "should be 200 code for HTTP Response on Delete Alerting" do
    byebug
    expect(@alerts_response.code).to  eq("200")
  end

  it "should be 200 code for HTTP Response on Delete Event" do
    byebug
    expect(@events_response.code).to eq("200")
  end
end
