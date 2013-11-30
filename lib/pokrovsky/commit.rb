module Pokrovsky
  class Commit
    def initialize date
      @date    = date
      @message = 'Rewriting History!'
      @flags   = [
          '--allow-empty'
      ]
    end

    def to_s
      'GIT_AUTHOR_DATE=%sT12:00:00 GIT_COMMITTER_DATE=%sT12:00:00 git commit %s -m "%s" > /dev/null' % [
          @date,
          @date,
          @flags.join(' '),
          @message
      ]
    end
  end
end