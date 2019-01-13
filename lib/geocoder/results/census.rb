require 'geocoder/results/base'

module Geocoder::Result
  class Census < Base

    def coordinates
      [@data.dig('coordinates', 'y').to_f, @data.dig('coordinates', 'x').to_f]
    end

    def address(format = :full)
      @data['matchedAddress'].gsub(/#{city}/i, city).gsub(/\, \d{5}$/, " #{postal_code}, #{country_code}")
    end


    def city
      @data.dig('addressComponents', 'city')&.split&.map(&:capitalize)&.join(' ')
    end

    def state
      @data.dig('addressComponents', 'state')
    end


    def country
      'United States'
    end

    def country_code
      'USA'
    end

    def postal_code
      @data.dig('addressComponents', 'zip')
    end


    def street_address
      @data['matchedAddress']&.split(',')[0]
    end

  end
end
