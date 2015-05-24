require 'spec_helper'

module Pokrovsky
  describe Day, :vcr do
    let(:d) { Day.new '2013-06-15', 4, 79, 19 }

    it 'should know that today is 2013-06-15' do
      expect(d.date).to eq '2013-06-15'
    end

    it 'should have an intensity of 4' do
      expect(d.intensity).to eq 4
    end

    it 'should know about max_commits being 79' do
      expect(d.max_commits).to eq 79
    end

    it 'should think the current_score is 19' do
      expect(d.current_score).to eq 19
    end

    it 'should be ready to unleash 89 commits' do
      expect(d.length).to eq 89
    end

    let(:e) { Day.new '1974-06-15', 3, 67, 21 }

    it 'should be loaded with 48 commits' do
      expect(e.length).to eq 48
    end

    it 'should have strings that look like git commits' do
      expect(e.to_s).to match /GIT_AUTHOR_DATE=1974-06-15T12:00:00 GIT_COMMITTER_DATE=1974-06-15T12:00:00 git commit --allow-empty -m "Rewriting History!" > \/dev\/null/
    end

    it 'should have 48 of those' do
      expect(e.to_s.lines.length).to eq 48
    end

    it 'should contain identical commits' do
      expect(e.to_s.lines.uniq.length).to eq 1
    end

    let(:f) { Day.new '1970-01-01', 4, 0, 0 }

    it 'should not just give up because everything is empty' do
      expect(f.length).to eq 16
    end
  end
end
