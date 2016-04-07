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
      ).and_return(['follower1', 'follower2', 'follower3'])
    end

    context 'without a block' do
      it 'should send a GET request for the followers belonging to the given repo' do
        following.followers('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'should send a GET request for the followers belonging to the given repo' do
        following.followers('mock_username', 'mock_repo') { |follower| follower }
      end
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
      ).and_return(['followed1', 'followed2', 'followed3'])
    end

    context 'without a block' do
      it 'should send a GET request for the followers belonging to a particular user' do
        following.followed
      end
    end

    context 'with a block' do
      it 'should send a GET request for the followers belonging to a particular user' do
        following.followed { |followed| followed }
      end
    end
  end
end
