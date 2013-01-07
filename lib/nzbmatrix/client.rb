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


    def get(*args)
      RestClient.get(*args)
    end
    
    def api_request(function, params)
      params = params.merge(:t => function, :apikey => @api_key)
      get "#{endpoint}/api", :params => params
    end

    def search(query, options = {})
      # FIXME: provide a nicer interface so that users don't have to
      # know category ids (and so forth)
      params = options.merge(:q => query)
      api_request(:search, params)
    end
  end
end
