module Nzbmatrix
  class TvItem < Item
    CATEGORY_SD = "5030"
    CATEGORY_HD = "5040"
    
    attr_accessor :rageid, :season, :episode

    def series
      @series ||= Series.find_by_tvrage_id(rageid)
    end

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
    
    def acquired?
      acquired ||= calculate_acquired_status
    end

    def calculate_acquired_status
      series or return false
      season = series.seasons.find_by_number(season_number) or return false
      episode = season.episodes.find_by_number(episode_number) or return false
      episode.exist? or return false
      episode.locations.any? do |location|
        episode.quality(location) == quality
      end
    end

    def valid?
      [rageid, season, episode].all?(&:present?)
    end

    # True if we know about this series and we haven't yet got this
    # episode in this quality. And somebody wants it.
    def should_fetch?
      series and not acquired? and any_subscribers?
    end

    def any_subscribers?
      series.subscriptions.where(:quality => quality).exists?
    end

    def pretty_name
      "#{rageid ? (series && series.name) : "??"} #{season}#{episode}"
    end

    def inspect
      variables = (instance_variables - [:@element]).map do |ivar_name|
        [ivar_name, instance_variable_get(ivar_name).inspect].join("=")
      end
      "#<#{self.class.name} %s \"%s\">" % [variables.join(" "), pretty_name]
    end
  end
end
