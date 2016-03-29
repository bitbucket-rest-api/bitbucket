require 'spec_helper'

describe BitBucket::Issues::Milestones do
  subject { described_class.new }

  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/milestones',
        {},
        {}
      ).and_return(['milsetone1', 'milestone2', 'milestone3'])
    end

    context 'without a block' do
      it 'makes a GET request for the milestones belonging to the given repo' do
        subject.list('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'makes a GET request for the milestones belonging to the given repo' do
        subject.list('mock_username', 'mock_repo') { |milestone| milestone }
      end
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/milestones/mock_milestone_id',
        {},
        {}
      )
    end

    it 'makes a GET request for the given milestone belonging to the given repo' do
      subject.get('mock_username', 'mock_repo', 'mock_milestone_id')
    end
  end

  describe '#create' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/issues/milestones',
        { 'name' => 'mock_name' },
        {}
      )
    end

    it 'makes a POST request for a new milestone that will belong to the given repo' do
      subject.create('mock_username', 'mock_repo', name: 'mock_name')
    end
  end

  describe '#update' do
    before do
      expect(subject).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/issues/milestones/mock_milestone_id',
        { 'name' => 'mock_name' },
        {}
      )
    end

    it 'makes a PUT request for the given milestone belonging to the given repo' do
      subject.update('mock_username', 'mock_repo', 'mock_milestone_id', name: 'mock_name')
    end
  end

  describe '#delete' do
    before do
      expect(subject).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo/issues/milestones/mock_milestone_id',
        {},
        {}
      )
    end

    it 'makes a PUT request for the given milestone belonging to the given repo' do
      subject.delete('mock_username', 'mock_repo', 'mock_milestone_id')
    end
  end
end
