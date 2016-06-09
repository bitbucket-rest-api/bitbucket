require 'spec_helper'

describe BitBucket::Repos::Keys do
  let(:deploy_keys) { described_class.new }
  describe '.list' do
    before do
      expect(deploy_keys).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/deploy-keys/',
        {},
        {}
      ).and_return(['key1', 'key2', 'key3'])
    end

    context 'without a block' do
      it 'should make a GET request for the deploy keys belonging to the given repo' do
        deploy_keys.list('mock_username', 'mock_repo')
      end
    end

    context 'with a block' do
      it 'should make a GET request for the deploy keys belonging to the given repo' do
        deploy_keys.list('mock_username', 'mock_repo') { |key| key }
      end
    end
  end

  describe '.create' do
    before do
      expect(deploy_keys).to receive(:request).with(
        :post,
        '/1.0/repositories/mock_username/mock_repo/deploy-keys/',
        { 'key' => 'mock_ssh_key', 'label' => 'mock_label' },
        { headers: {"Content-Type"=>"application/json"} }
      )
    end

    it 'should make a POST request for the deploy keys belonging to the given repo' do
      deploy_keys.create('mock_username', 'mock_repo', { key: 'mock_ssh_key', label: 'mock_label' })
    end
  end

  describe '.edit' do
    before do
      expect(deploy_keys).to receive(:request).with(
         :put,
         '/1.0/repositories/mock_username/mock_repo/deploy-keys/1',
         { 'key' => 'mock_ssh_key', 'label' => 'mock_label' },
         {}
       )
    end

    it 'should make a PUT request for the deploy keys belonging to the given repo' do
      deploy_keys.edit('mock_username', 'mock_repo', 1, { key: 'mock_ssh_key', label: 'mock_label' })
    end
  end

  describe '.delete' do
    before do
      expect(deploy_keys).to receive(:request).with(
        :delete,
        '/1.0/repositories/mock_username/mock_repo/deploy-keys/mock_id',
        { 'key' => 'mock_ssh_key', 'label' => 'mock_label' },
        {}
      )
    end

    it 'should make a DELETE request for the deploy keys belonging to the given repo' do
      deploy_keys.delete('mock_username', 'mock_repo', 'mock_id', { key: 'mock_ssh_key', label: 'mock_label' })
    end
  end
end
