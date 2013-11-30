module Pokrovsky
  class Day
    attr_reader :date, :strength

    include Enumerable

    def initialize date
      @date     = date
      @strength = 4
      @commits_per_day = 10

      populate
    end

    def populate
      @commits = []
      (@strength * @commits_per_day).times do
        @commits << Pokrovsky::Commit.new(@date)
      end
    end

    def strength= strength
      @strength = strength
      populate
    end

    def each(&block)
      @commits.each(&block)
    end

    def length
      @commits.length
    end

    def [] key
      @commits[key]
    end

    def inspect
      "< %s: date: %s, commits: %d>" % [
          self.class,
          @date,
          @commits
      ]
    end

    def to_s
      s = ''
      @commits.each do |commit|
        s << commit.to_s
        s << "\n"
      end

      s
    end
  end
end