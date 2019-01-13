require 'geocoder/results/nominatim'

module Geocoder::Result
  class LocationIq < Nominatim
    def street_address
      [
        house_number,
        street
      ].compact.join(" ")
    end

    def state_code
      state_to_code(state)
    end

    def country_code
      standardized_country_code(super)
    end

    def formatted_address
      [
        street_address,
        city,
        "#{state_code} #{postal_code}".strip,
        country_code
      ].compact.join(", ").strip
    end
  end
end
