module Nzbmatrix
  class ApiResponseParser

    def parse(response)
      parsed = response.split(/^\|$/).map do |block|
        parse_block(block)
      end

      parsed.reject do |hash|
        hash.empty?
      end
    end

    def parse_block(block)
      block.split("\n").inject({}) do |h, line|
        if (parsed = parse_line(line))
          key, value = parsed
          h[key] = value
        end
        
        h
      end
    end

    def parse_line(line)
      unless line.empty?
        key, value = line.split(":", 2)
        value.gsub!(/;$/, "") unless value.nil?
        [key, value]
      end
    end
  end
end
