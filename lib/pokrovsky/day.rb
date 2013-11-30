module Pokrovsky
  class Day
    attr_reader :date, :strength

    include Enumerable

    def initialize date
      @date     = date
      @strength = 4

      populate
    end

    def populate
      @commits = []
      (@strength * 18).times do
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
  end
end