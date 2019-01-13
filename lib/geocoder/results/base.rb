module Geocoder
  module Result
    class Base

      # data (hash) fetched from geocoding service
      attr_accessor :data

      # true if result came from cache, false if from request to geocoding
      # service; nil if cache is not configured
      attr_accessor :cache_hit

      ##
      # Takes a hash of data from a parsed geocoding service response.
      #
      def initialize(data)
        @data = data
        @cache_hit = nil
      end

      ##
      # A string in the given format.
      #
      # This default implementation dumbly follows the United States address
      # format and will return incorrect results for most countries. Some APIs
      # return properly formatted addresses and those should be funneled
      # through this method.
      #
      def address(format = :full)
        if state_code.to_s != ""
          s = ", #{state_code}"
        elsif state.to_s != ""
          s = ", #{state}"
        else
          s = ""
        end
        "#{city}#{s} #{postal_code}, #{country}".sub(/^[ ,]*/, '')
      end

      ##
      # A two-element array: [lat, lon].
      #
      def coordinates
        [@data['latitude'].to_f, @data['longitude'].to_f]
      end

      def latitude
        coordinates[0]
      end

      def longitude
        coordinates[1]
      end

      def state
        fail
      end

      def province
        state
      end

      def state_code
        fail
      end

      def province_code
        state_code
      end

      def country
        fail
      end

      def country_code
        fail
      end

      def state_to_code(state_name)
        {
          'alabama' => 'AL',
          'alaska' => 'AK',
          'arizona' => 'AZ',
          'arkansas' => 'AR',
          'california' => 'CA',
          'colorado' => 'CO',
          'connecticut' => 'CT',
          'delaware' => 'DE',
          'district of columbia' => 'DC',
          'd.c.'  => 'DC',
          'florida' => 'FL',
          'georgia' => 'GA',
          'hawaii' => 'HI',
          'idaho' => 'ID',
          'illinois' => 'IL',
          'indiana' => 'IN',
          'iowa' => 'IA',
          'kansas' => 'KS',
          'kentucky' => 'KY',
          'louisiana' => 'LA',
          'maine' => 'ME',
          'maryland' => 'MD',
          'massachusetts' => 'MA',
          'michigan' => 'MI',
          'minnesota' => 'MN',
          'mississippi' => 'MS',
          'missouri' => 'MO',
          'montana' => 'MT',
          'nebraska' => 'NE',
          'nevada' => 'NV',
          'new hampshire' => 'NH',
          'n.h.'  => 'NH',
          'new jersey' =>	'NJ',
          'n.j.' =>	'NJ',
          'new mexico' => 'NM',
          'n.m.' => 'NM',
          'new york' => 'NY',
          'n.y.' => 'NY',
          'north carolina' => 'NC',
          'n.c.' => 'NC',
          'north dakota' => 'ND',
          'n.d.' => 'ND',
          'ohio' => 'OH',
          'oklahoma' => 'OK',
          'oregon' => 'OR',
          'pennsylvania' => 'PA',
          'rhode island' => 'RI',
          'r.i.' => 'RI',
          'south carolina' => 'SC',
          's.c.' => 'SC',
          'south dakota' => 'SD',
          's.d.' => 'SD',
          'tennessee'	=> 'TN',
          'texas' => 'TX',
          'utah'	=>	'UT',
          'vermont'	=> 'VT',
          'virginia'=> 'VA',
          'washington'=> 'WA',
          'west virginia' => 'WV',
          'w.va.' => 'WV',
          'wisconsin'	=> 'WI',
          'wyoming'	=> 'WY',
          'american samoa' => 'AS',
          'guam'	=>	'GU',
          'marshall islands' =>	'MH',
          'micronesia' => 'FM',
          'northern marianas' => 'MP',
          'palau' => 'PW',
          'puerto rico' => 'PR',
          'p.r.' => 'PR',
          'virgin islands' => 'VI'
        }[state_name&.downcase]||state_name
      end

      def standardized_country_code(country_code)
        {
          'us' => 'USA'
        }[country_code&.downcase]||country_code
      end
    end
  end
end
