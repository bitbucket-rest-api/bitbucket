require 'spec_helper'

describe BitBucket::Repos::Components do
  subject { described_class.new }
  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/components',
        {},
        {}
      )
    end

    it 'makes a GET request for all components defined in the issue tracker' do
      subject.list('mock_user', 'mock_repo')
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_user/mock_repo/components/1',
        {},
        {}
      )
    end

    it 'makes a GET request for all components defined in the issue tracker' do
      subject.get('mock_user', 'mock_repo', 1)
    end
  end
end
