require 'spec_helper'

describe BitBucket::Repos::Commit do
  let(:commit) { BitBucket::Repos::Commit.new }

  describe '.get' do
    before do
      expect(commit).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/commit/557557b267628ccc3060de76c16eb9c269e4576c',
        {},
        {}
      )
    end

    it 'should send a GET request for the commit with given hash belonging to the given repo' do
      commit.get('mock_username', 'mock_repo', '557557b267628ccc3060de76c16eb9c269e4576c')
    end
  end
end
