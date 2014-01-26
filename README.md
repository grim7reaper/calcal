# CalCal — Calendrical Calculations

This is a pure Ruby implementation of several calendrical calculations
algorithms.

Most of the algorithms are based on the book "Calendrical Calculations",
3rd edition written by Edward M. Reingold and Nachum Dershowitz.

## Description

This library:

* allows easy dates conversion from/to different calendars.
* provides convenient functions to compare dates (even if they are expressed in
  different calendars!).
* provides basics arithmetic functions (add/subtract days, compute a difference
  in days between two dates, ...).

## Example

    require 'calcal'
    CalCal::Gregorian.new(2014, 1, 26).valid? # return true
    CalCal::Gregorian.new(2012, 2, 29).valid? # return true
    CalCal::Gregorian.new(2013, 2, 29).valid? # return false
    
    today = CalCal::Gregorian.new(2014, 1, 26)
    CalCal::Egyptian.from_rd(today.to_rd) # Convert from Gregorian calendar to Egyptian calendar

## Supported calendars

* Egyptian
* Armenian
* Gregorian

## Install

    $ gem build calcal.gemspec
    $ gem install calcal-X.Y.Z.gem

## Testing

To run the tests:

    $ rake

## Reference

Nachum Dershowitz, Edward M. Reingold
"[Calendrical Calculations](http://emr.cs.iit.edu/home/reingold/calendar-book/third-edition/index.html)"
Cambridge University Press; 3rd edition (December 10, 2007);
Paperback; ISBN-13: 9780521702386
