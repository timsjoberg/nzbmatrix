module Nzbmatrix
  class SearchResult
    
    require "time"
    require "fileutils"
    
    attr_accessor :id
    attr_accessor :name
    attr_accessor :link
    attr_accessor :size
    attr_accessor :index_date
    attr_accessor :usenet_date
    attr_accessor :category
    attr_accessor :group
    attr_accessor :comments
    attr_accessor :hits
    attr_accessor :weblink
    attr_accessor :language
    attr_accessor :image_url
    attr_accessor :region

    def initialize(api_response, client)
      @client = client
      
      @id = api_response["NZBID"].to_i
      @name = api_response["NZBNAME"]
      @link = api_response["LINK"]
      @size = api_response["SIZE"].to_f
      @index_date = Time.parse(api_response["INDEX_DATE"]) rescue nil
      @usenet_date = Time.parse(api_response["USENET_DATE"]) rescue nil
      @category = api_response["CATEGORY"]
      @group = api_response["GROUP"]
      @comments = api_response["COMMENTS"].to_i
      @hits = api_response["HITS"].to_i
      @nfo = api_response["NFO"] == "yes"
      @weblink = api_response["WEBLINK"]
      @language = api_response["LANGUAGE"]
      @image_url = api_response["IMAGE"]
      @region = api_response["REGION"].to_i
    end

    def download(path = nil)
      path ||= Dir.pwd
      path = File.expand_path(path)
      FileUtils.mkdir_p(path)
      
      nzb = @client.download(id)
      File.open(File.join(path, "#{name}.nzb"), "w") { |f| f.write(nzb) }

      id
    end

    def has_nfo?
      !!@nfo
    end

    def has_image?
      !!@image_url
    end
  end
end
