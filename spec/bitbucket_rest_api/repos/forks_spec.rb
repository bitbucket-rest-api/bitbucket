require 'spec_helper'

describe BitBucket::Repos::Forks do
  let(:forks) { BitBucket::Repos::Forks.new }

  describe '.list' do
    before do
      expect(forks).to receive(:request).with(
        :get,
        '/2.0/repositories/mock_username/mock_repo/forks/',
        {},
        {}
      ).and_return(['fork1', 'fork2', 'fork3'])
    end

    context 'without a block' do
      it 'sends a GET request for the forks of the given repo' do
        forks.list('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'sends a GET request for the forks of the given repo' do
        forks.list('mock_username', 'mock_repo') { |fork| fork }
      end
    end
  end

  # TODO: make sure this is documented in the README since it is not so
  # in the official API docs
  describe '.create' do
    before do
      expect(forks).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/fork',
        { 'name' => 'mock_fork_name'},
        {}
      )
    end

    it 'should send a POST request to create a fork of the given repo' do
      forks.create('mock_username', 'mock_repo', { 'name' => 'mock_fork_name' })
    end
  end
end
