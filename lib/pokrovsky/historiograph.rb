require 'json'

module Pokrovsky
  class Historiograph
    attr_accessor :repo
    attr_reader :user, :max_commits

    include Enumerable

    def initialize json
      @json  = JSON.parse(json)['data']
      @width = @json[0].length
      populate
    end

    def populate
      @days = []
      date  = start_date
      @width.times do |i|
        @json.each do |row|
          if row[i] != 0
            @days << Pokrovsky::Day.new(date.strftime "%F")
          end
          date += 1
        end
      end
    end

    def start_date
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

    def user= user
      @user = user
      get_max_commits
    end

    def get_max_commits
      url       = 'https://github.com/users/%s/contributions_calendar_data' % [
          @user
      ]
      c         = Curl::Easy.new("%s" % url)
      c.headers = {
          'Accept' => 'application/json'
      }
      c.perform

        (JSON.parse(c.body_str).map { |i| i = i[-1] }).max.to_i
    end

    def multiplier
      (@max_commits / 4).to_i
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

