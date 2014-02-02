#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/degree'

module CalCal
  # This class represents a location on Earth.
  #
  # A location on Earth is defined by a latitude and a longitude.
  # Latitudes are in degree from Equator (north latitudes are positives, south
  # latitudes are negatives) and longitudes are in degree from Greenwich
  # meridian (east longitudes are positives, west longitudes are negatives).
  #
  # A location is also associated to a timezone (required for determining the
  # local time) and an elevation above sea level (used for local sunrise and
  # sunset for example).
  # Timezones are defined as difference from Universal Time.
  #
  # Reference: section (13.1) of Calendrical Calculations, 3rd edition.
  class Position
    # @!attribute [r] latitude
    #   @return [Float] the latitude (degree).
    attr_reader :latitude

    # @!attribute [r] longitude
    #   @return [Float] the longitude (degree).
    attr_reader :longitude

    # @!attribute [r] elevation
    #   @return [Float] the elevation above sea level (m).
    attr_reader :elevation

    # @!attribute [r] timezone
    #   @return [Fixnum] the timezone (fraction of a day).
    attr_reader :timezone

    # Initializes a position.
    #
    # @param latitude  [Float] latitude (degree).
    # @param longitude [Float] longitude (degree).
    # @param elevation [Float] elevation above sea level (m).
    # @param timezone  [Fixnum] timezone (fraction of a day).
    def initialize(latitude, longitude, elevation, timezone)
      @latitude  = latitude
      @longitude = longitude
      @elevation = elevation
      @timezone  = timezone
    end

    # Returns the direction of `focus` from self.
    #
    # Equation (13.5) of Calendrical Calculations, 3rd edition.
    #
    # @note Imperfect arithmetic accuracy can result in meaningless results
    #       when the focus is nearly coincident or antipodal.
    #
    # @param focus [Position] a location on Earth.
    # @return [Float] the direction of `focus` from self (degree, east of due
    # north).
    def direction(focus)
      y = Degree.sin(focus.longitude - @longitude)
      x = Degree.cos(@latitude)*Degree.tan(focus.latitude) -
          Degree.sin(@latitude)*Degree.cos(@longitude - focus.longitude)

      if (x == 0 && y == 0) || focus.latitude == 90
        return 0.0
      elsif focus.latitude == -90
        return 180.0
      else
        return Degree.atan2(y, x)
      end
    end
  end
end
