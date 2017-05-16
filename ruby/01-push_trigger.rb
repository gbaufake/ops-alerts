require 'byebug'
require 'openSSL'
require 'json'

describe "Pushing Triggers Should be as answer as 200 on HTTP Code" do
  it "should be true" do
        require 'uri'
        require 'net/http'

        url = URI("https://hawkular-metrics.cloud5.jonqe.lab.eng.bos.redhat.com/hawkular/alerts/import/all")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["hawkular-tenant"] = 'hawkular'
        request["content-type"] = 'application/json'
        request["authorization"] = 'Basic aGF3a3VsYXI6Rk5BODBqWDlvT3haamdF'
        request["cache-control"] = 'no-cache'

        request.body =  JSON.parse(File.read('autoresolve-trigger.json')).to_s

        response = http.request(request)

        expect(response.code).to   eq(200)

  end
end
