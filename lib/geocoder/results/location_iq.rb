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
  end
end
