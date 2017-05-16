require 'byebug'
require 'openSSL'
require 'json'
require 'uri'
require 'net/http'
require 'dotenv'
require 'to_bool'

describe "Pushing Triggers " do
  it "should be 200 code of HTTP Response" do
        hawkular_url = ENV['HAWKULAR_URL']
        url = URI(hawkular_url)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = ENV['HAWKULAR_USE_SSL'].to_bool
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["hawkular-tenant"] = ENV['HAWKULAR_TENANT']
        request["content-type"] = 'application/json'
        request["authorization"] = ENV['HAWKULAR_TOKEN']
        request["cache-control"] = 'no-cache'
        request.body =  JSON.parse(File.read('autoresolve-trigger.json')).to_json

        response = http.request(request)
        expect(response.code).to   eq("200")

  end
end
