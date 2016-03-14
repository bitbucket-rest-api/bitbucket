require 'spec_helper'

describe BitBucket::Repos::Following do
  let(:following) { BitBucket::Repos::Following.new }

  describe '.followers' do
    before do
      expect(following).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/followers/',
        {},
        {}
      )
    end

    it 'should send a GET request for the followers belonging to the given repo' do
      following.followers('mock_username', 'mock_repo')
    end
  end

  # TODO: implement this method in the User class where it belongs
  describe '.followed' do
    before do
      expect(following).to receive(:request).with(
        :get,
        '/1.0/user/follows',
        {},
        {}
      )
    end

    it 'should send a GET request for the followers belonging to a particular user' do
      following.followed
    end
  end
end
