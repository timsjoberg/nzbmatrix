module Nzbmatrix
  require 'rest_client'

  class Client

    require "nzbmatrix/api_response_parser"
    require "nzbmatrix/search_result"
    
    BASE_URL = "https://api.nzbmatrix.com/v1.1"
    
    def initialize(username, api_key)
      @username = username
      @api_key = api_key
      @creds = { :username => @username, :apikey => @api_key }
      @parser = ApiResponseParser.new
    end

    def download(nzb_id)
      RestClient.get "#{BASE_URL}/download.php", :params => { :id => nzb_id }.merge(@creds)
    end

    def details(nzb_id)
      params = { :id => nzb_id }.merge(@creds)
      response = RestClient.get("#{BASE_URL}/details.php", :params => params)
      parsed_response = @parser.parse(response).first
      result = SearchResult.new(parsed_response, self)
      result.id = nzb_id

      result
    end

    # Options
    # :catid => CATEGORYID all categories searched if left blank
    # :num => MAX RESULTS default 15
    # :age => MAX AGE default full site retention. Age must be number of "days" eg 200
    # :region => REGION default not limited. 1 = PAL, 2 = NTSC, 3 = FREE
    # :group => GROUP default all groups will be searched, format is full group name "alt.binaries.X"
    # :larger => MIN SIZE minimum size in MB
    # :smaller => MAX SIZE maximum size in MB
    # :minhits => MIN HITS
    # :maxhits => MAX HITS
    # :maxage => {MAX AGE} same as :age
    # :englishonly => 1 if added the search will only return ENGLISH and UNKNOWN matches
    # :searchin => SEARCH FIELD default name. possible options: name, subject, weblink
    def search(search_term, opts = {})
      params = { :search => search_term }.merge(opts).merge(@creds)
      response = RestClient.get("#{BASE_URL}/search.php", :params => params)
      @parser.parse(response).map do |parsed|
        SearchResult.new(parsed, self)
      end
    end

    def account
      RestClient.get "#{BASE_URL}/account.php", :params => @creds
    end

    def add_bookmark(nzb_id)
      RestClient.get "#{BASE_URL}/bookmarks.php", :params => { :id => nzb_id, :action => 'add' }.merge(@creds)
    end

    def remove_bookmark(nzb_id)
      RestClient.get "#{BASE_URL}/bookmarks.php", :params => { :id => nzb_id, :action => 'remove' }.merge(@creds)
    end
  end
end
