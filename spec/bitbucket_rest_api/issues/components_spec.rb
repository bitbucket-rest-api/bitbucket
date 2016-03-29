require 'spec_helper'

describe BitBucket::Issues::Components do
  subject { described_class.new }

  describe '#list' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/components',
        {},
        {}
      ).and_return(['component1', 'component2', 'component3'])
    end

    context 'without a block' do
      it 'makes a GET request for the components belonging to the given repo' do
        subject.list('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'makes a GET request for the components belonging to the given repo' do
        subject.list('mock_username', 'mock_repo') { |component| component }
      end
    end
  end

  describe '#get' do
    before do
      expect(subject).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/issues/components/mock_component_id',
        {},
        {}
      )
    end

    it 'makes a GET request for the given component belonging to the given repo' do
      subject.get('mock_username', 'mock_repo', 'mock_component_id')
    end
  end

  describe '#create' do
    before do
      expect(subject).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/issues/components',
        { 'name' => 'mock_name' },
        {}
      )
    end

    it 'makes a POST request for a new component that will belong to the given repo' do
      subject.create('mock_username', 'mock_repo', name: 'mock_name')
    end
  end

  describe '#update' do
    before do
      expect(subject).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/issues/components/mock_component_id',
        { 'name' => 'mock_name' },
        {}
      )
    end

    it 'makes a PUT request for the given component belonging to the given repo' do
      subject.update('mock_username', 'mock_repo', 'mock_component_id', name: 'mock_name')
    end
  end

  describe '#delete' do
    before do
      expect(subject).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo/issues/components/mock_component_id',
        {},
        {}
      )
    end

    it 'makes a PUT request for the given component belonging to the given repo' do
      subject.delete('mock_username', 'mock_repo', 'mock_component_id')
    end
  end
end
