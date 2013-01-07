module Nzbmatrix
  class TvItem < Item
    CATEGORY_SD = "5030"
    CATEGORY_HD = "5040"
    
    attr_accessor :rageid, :season, :episode

    def quality
      if category.include?(CATEGORY_HD)
        "720p"
      elsif category.include?(CATEGORY_SD)
        "352p"
      else
        :unknown
      end
    end

    def season_number
      season[1..-1].to_i
    end

    def episode_number
      episode[1..-1].to_i
    end
    def inspect
      variables = (instance_variables - [:@element]).map do |ivar_name|
        [ivar_name, instance_variable_get(ivar_name).inspect].join("=")
      end
      "#<#{self.class.name} %s \"%s\">" % [variables.join(" "), title]
    end
  end
end
