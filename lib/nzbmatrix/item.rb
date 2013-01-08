module Nzbmatrix
  class Item
    attr_accessor :element, :guid, :category, :size
    
    def initialize(element)
      @element = element
      @category = []
      assign
    end

    def attributes
      element.xpath("newznab:attr").map do |e|
        [e.attribute("name").value, e.attribute("value").value]
      end
    end
    
    def assign
      attributes.each do |name, value|
        next unless respond_to?(name)
        ivar = instance_variable_get("@#{name}")

        if Enumerable === ivar
          ivar << value
        else
          ivar = value
        end

        instance_variable_set("@#{name}", ivar)
      end
    end

    def link
      element.xpath("link").text
    end

    def title
      element.xpath("title").text
    end

    def published
      Time.parse(element.xpath("pubDate").text)
    end
  end
end
