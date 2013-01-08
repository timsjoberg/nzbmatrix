module Nzbmatrix
  class Client

    require "rest_client"
    
    ENDPOINT = "http://nzb-matrix.eu"

    attr_accessor :user_id, :api_key, :endpoint
    
    def initialize(user_id, api_key, endpoint = ENDPOINT)
      @user_id = user_id
      @api_key = api_key
      @endpoint = endpoint
    end

    
    def api_request(function, params)
      params = params.merge(:t => function, :apikey => @api_key)
      get "#{endpoint}/api", params: params
    end

    def search(query, options = {})
      # FIXME: provide a nicer interface so that users don't have to
      # know category ids (and so forth)
      params = options.merge(:q => query)
      response = api_request(:search, params)
      Parser.new.call(response)
    end

    def get_nzb(guid, options = {})
      params = options.merge(:i => user_id, :r => api_key)
      content = get("#{endpoint}/getnzb/#{guid}.nzb", params: params)

      # FIXME: Can we get the name from the HTTP headers and save on
      # parsing the document? If so, is this a good idea? Maybe the
      # name in the document is more correct, or maying parsing it
      # will show up a parsing error earlier that you might otherwise
      # detect it.
      
      document = Nokogiri::XML(content)
      filename = document.at_css("meta[type=name]").text
      [filename, content]
    end


    protected

    def get(*args)
      RestClient.get(*args)
    end
  end
end
