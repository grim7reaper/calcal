#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'date'

module CalCal
  # The Date mixin is used by date classes which may be used in calendrical
  # calculations and that can be converted between each other.
  #
  # The class must define the from_rd class method and the to_rd instance
  # method.
  module Date
    include Comparable

    # @see Module#included
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
    end

    # Class Methods used for calendrical calculations.
    module ClassMethods
      # Creates date from a Rata Die
      #
      # @param rd [Integer] Rata Die.
      # @return the corresponding date.
      def from_rd(rd)
      end

      # Creates date from another date.
      #
      # @param date [#to_rd] a date.
      # @return the corresponding date.
      def from_date(date)
        rata_die = date.to_rd
        return self.from_rd(rata_die)
      end
    end

    # Instance Methods used for calendrical calculations.
    module InstanceMethods
      # Converts the date into Rata Die.
      #
      # @return [Integer] Rata Die.
      def to_rd
      end

      # Tests if the date is valid.
      #
      # @return true if the date is valid, otherwise false.
      def valid?
        self.eql? self.class.from_rd(self.to_rd)
      end

      # Returns a date pointing `other` days after self.
      #
      # @param other [Integer] number of days to add.
      # @return a date pointing `other` days after self.
      def +(other)
        return self.class.from_rd(self.to_rd + other)
      end

      # Returns the difference between self and `other ` if `other` has a method
      # to_rd. If `other` is an integer, returns a date pointing `other` days
      # before self.
      #
      # @param other [#to_rd, Integer] a date or a number of days to subtract.
      # @return the difference, in day, between self and `other ` if `other` has
      #   a method to_rd. If `other` is an integer, returns a date pointing
      #   `other` days before self.
      def -(other)
        # Date - Date => return a difference (in day)
        if other.respond_to? :to_rd
          return self.to_rd - other.to_rd
        else
          return self.class.from_rd(self.to_rd - other)
        end
      end

      # Compares self against `other`.
      #
      # @param other [#to_rd] a date object.
      # @return -1, 0, or +1 depending on whether self is less than, equal to,
      #   or greater than `other`.
      def <=>(other)
        return nil unless other.respond_to? :to_rd
        return self.to_rd <=> other.to_rd
      end
    end
  end
end
