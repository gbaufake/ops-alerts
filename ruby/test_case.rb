require 'uri'
require 'net/http'
require 'openssl'

class TestCase
def initialize(parameters)
  @name = parameters[:name]
  @url = URI(parameters[:hawkular_envirorment] + parameters[:hawkular_url])
  @http = Net::HTTP.new(@url.host, @url.port)
  @http.use_ssl = parameters[:ssl]
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  case parameters[:http_method]

  when 'GET'
    @request = Net::HTTP::Get.new(@url)
    configure_base_request(parameters)

  when 'POST'
    @request = Net::HTTP::Post.new(@url)
    configure_base_request(parameters)
    configure_body_request(parameters)

  when 'DELETE'
    @request = Net::HTTP::Delete.new(@url)
    configure_base_request(parameters)

  when 'PUT'
    @request = Net::HTTP::Put.new(@url)
    configure_base_request(parameters)
  end
end

def configure_base_request(parameters)
  @request["hawkular-tenant"] = parameters[:hawkular_tenant]
  @request["content-type"] =parameters[:content_type]
  @request["authorization"] = parameters[:authorization]
  @request["cache-control"] = parameters[:no_cache]
end


def configure_body_request(parameters)
  @request.body=parameters[:body]
end

def peform_request
  return @http.request(@request)
end



end
