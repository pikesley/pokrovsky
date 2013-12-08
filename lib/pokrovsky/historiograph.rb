require 'json'

module Pokrovsky
  class Historiograph
    attr_accessor :repo
    attr_reader :user, :max_commits

    include Enumerable

    def initialize json, user, repo
      @json             = JSON.parse(json)['data']
      @width            = @json[0].length
      @user             = user
      @repo             = repo
      @start_date       = get_start_date
      @current_calendar = get_current_calendar

      populate
    end

    def populate
      @days = []
      date  = get_start_date
      @width.times do |i|
        @json.each do |row|
          if row[i] != 0
            nice_date = date.strftime "%F"
            @days << Pokrovsky::Day.new(
                nice_date,
                row[i],
                get_max_commits,
                @current_calendar[nice_date]
            )
          end
          date += 1
        end
      end
    end

    def get_start_date
      year_ago = Date.parse(Time.new.to_s) - 365
      offset   = ((52 - @width) / 2) * 7

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

    def get_max_commits
      (@current_calendar.map { |k, v| v }).max
    end

    def get_current_calendar
      url       = 'https://github.com/users/%s/contributions_calendar_data' % [
          @user
      ]
      c         = Curl::Easy.new("%s" % url)
      c.headers = {
          'Accept' => 'application/json'
      }
      c.perform

      @current_calendar = {}
      JSON.parse(c.body_str).each do |pair|
        d                    = Date.parse(pair[0])
        k                    = d.strftime "%F"
        @current_calendar[k] = pair[1]
      end

      @current_calendar
    end

    def to_s
      s = "" "#!/bin/bash
git init %s
cd %s
touch README.md
git add README.md
" "" % [
          @repo,
          @repo,
          @repo
      ]

      @days.each do |day|
        s << day.to_s
      end

      s << "" "git remote add origin git@github.com:%s/%s.git
git pull
git push -u origin master
" "" % [
          @user,
          @repo
      ]
      s
    end
  end
end

