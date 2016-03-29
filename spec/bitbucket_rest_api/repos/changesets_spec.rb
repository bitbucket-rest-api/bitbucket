require 'spec_helper'

describe BitBucket::Repos::Changesets do
  let(:changesets) { BitBucket::Repos::Changesets.new }

  describe '.list' do
    before do
      expect(changesets).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/changesets',
        {},
        {}
      )
    end

    it 'should send a GET request for the changesets belonging to the given repo' do
      changesets.list('mock_username', 'mock_repo')
    end
  end

  describe '.get' do
    before do
      expect(changesets).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/changesets/test_sha',
        {},
        {}
      )
    end

    it 'should send a GET request for a particular changeset belonging to the given repo' do
      changesets.get('mock_username', 'mock_repo', 'test_sha')
    end
  end
end
