require 'net/http'

begin
  require 'net/http/persistent'
rescue LoadError
  # do nothing
end

module SensorsAnalytics
  class Http
    def initialize(server_url, options = {})
      @uri = _get_uri(server_url)
      @keep_alive = options[:keep_alive] && defined?(Net::HTTP::Persistent)
    end

    def request(form_data, headers = {})
      init_header = {"User-Agent" => "SensorsAnalytics Ruby SDK"}
      headers.each do |key, value|
        init_header[key] = value
      end

      request = Net::HTTP::Post.new(@uri.request_uri, init_header)
      request.set_form_data(form_data)

      response = do_request(request)
      [response.code, response.body]
    end

    private

    def do_request(request)
      if @keep_alive
        @client ||= begin
          client = Net::HTTP::Persistent.new name: "sa_sdk"
          client.use_ssl = true if @uri.port == 443
          client.open_timeout = 10
          client
        end
        @client.request(@uri, request)
      else
        client = Net::HTTP.new(@uri.host, @uri.port)
        client.use_ssl = true if @uri.port == 443
        client.open_timeout = 10
        client.continue_timeout = 10
        client.read_timeout = 10
        if @uri.scheme == "https"
            client.use_ssl = true
        end
        client.request(request)
      end
    end

    def _get_uri(url)
      begin
        URI.parse(url)
      rescue URI::InvalidURIError
        host = url.match(".+\:\/\/([^\/]+)")[1]
        uri = URI.parse(url.sub(host, 'dummy-host'))
        uri.instance_variable_set('@host', host)
        uri
      end
    end
  end
end
