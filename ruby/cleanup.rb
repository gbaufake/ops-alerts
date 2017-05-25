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
require 'json'
require './test_case'

describe "Cleanup" do

  # Starting Requests
  before(:all) do
    # Triggers
     triggers_parameters = {"name" =>"Cleanup Triggers", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts/triggers/ops-example", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
      "http-method"=> 'DELETE', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
      :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :cache-control => 'no-cache' , :body => ""}

      @triggers_test_case = TestCase.new(triggers_parameters)
      @triggers_response = @triggers_test_case.peform_request

      # Events
      events_tags = "nodename|vm-48-124.eng.lab.tlv.redhat.com"
      events_parameters = {"name" =>"Cleanup Alerts", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
        "hawkular-url" => "hawkular/alerts/events/delete?tags=#{alerts_tags}", "ssl"=> ENV['HAWKULAR_USE_SSL'].to_bool,
        "http-method"=> 'PUT', :hawkular_tenant=> ENV['HAWKULAR_TENANT'],
        :content_type => 'application/json',  :authorization => ENV['HAWKULAR_TOKEN'], :cache-control => 'no-cache' , :body => ""}
        @events_test_case = TestCase.new(events_parameters)
        @events_response = @events_test_case.peform_request

 end
  it "should be 200 code for HTTP Response on Delete Trigger" do
    expect(@triggers_response.code).to eq("200")
  end

  it "should be 200 code for HTTP Response on Delete Alerting" do
    expect(@alerts_response.code).to  eq("200")
  end

  it "should be 200 code for HTTP Response on Delete Event" do
    expect(@events_response.code).to eq("200")
  end
end
