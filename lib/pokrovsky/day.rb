module Pokrovsky
  class Day
    attr_reader :date, :intensity, :max_commits, :current_score

    def initialize date, intensity, max_commits, current_score
      @date          = date
      @intensity     = intensity
      @max_commits   = max_commits
      @current_score = current_score #||= 0

      populate
    end

    def populate
      one_third_of_max_commits            = (@max_commits / 3.0).ceil
      this_times_the_intensity            = one_third_of_max_commits * @intensity
      total_commits                       = this_times_the_intensity
      total_commits_less_existing_commits = total_commits - @current_score
      if total_commits_less_existing_commits == 0
        total_commits_less_existing_commits = 16
      end

      @commits = []
      total_commits_less_existing_commits.times do
        @commits << Pokrovsky::Commit.new(@date)
      end
    end

    def length
      @commits.length
    end

    def inspect
      "< %s: date: %s, commits: %d >" % [
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
