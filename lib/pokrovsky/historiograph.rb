require 'pry'
require 'json'

module Pokrovsky
  class Historiograph

    include Enumerable

    def initialize json
      @json = JSON.parse(json)['data']
      @width = @json[0].length
      populate
    end

    def populate
#      binding.pry
      @days = []
      date = start_date
      @width.times do |i|
        @json.each do |row|
          if row[i] == 1
            @days << Pokrovsky::Day.new(date.strftime "%F")
          end
          date += 1
        end
      end
    end

    def start_date
      year_ago = Date.parse(Time.new.to_s) - 365
      offset = ((52 - @width) / 2) * 7

      start_date = year_ago + offset
      while not start_date.sunday?
        start_date += 1
      end

      start_date
    end

    def [] index
      @days[index]
    end

    def length
      @days.length
    end
  end
end