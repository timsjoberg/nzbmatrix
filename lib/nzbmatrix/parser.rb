module Nzbmatrix
  class Parser

    require "nokogiri"

    CATEGORY_ID_TO_CLASS = {
      5000 => TvItem,
    }
    
    def initialize
    end


    def item_class(item)
      category_ids = item.xpath('newznab:attr[@name="category"]').map do |el|
        el.attribute("value").value.to_i
      end
      CATEGORY_ID_TO_CLASS.fetch(category_ids.first, Item)
    end
    
    def call(xml)
      doc = Nokogiri::XML(xml)
      doc.xpath("//item").map do |item|
        item_class(item).new(item)
      end
    end
  end
end
