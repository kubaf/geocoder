require 'geocoder/lookups/base'
require "geocoder/results/census"

module Geocoder::Lookup
  class Census < Base

    def name
      "Census"
    end

    def supported_protocols
      [:https]
    end

    private # ---------------------------------------------------------------

    def base_query_url(query)
      "#{protocol}://geocoding.geo.census.gov/geocoder/locations/onelineaddress?"
    end


    def results(query)
      return [] unless doc = fetch_data(query)
      return [] unless doc['result'] && doc['result']['addressMatches']
      if r=doc['result']['addressMatches']
        return [] if r.nil? || !r.is_a?(Array) || r.empty?
        return r
      end
      []
    end

    def query_url_census_params(query)
      params = {
        :benchmark => 9,
        :format => 'json'
      }
    end

    def query_url_params(query)
      query_url_census_params(query).merge({:address => query.sanitized_text}).merge(super)
    end
  end
end
