require 'spec_helper'

describe BitBucket::Repos do
  let(:repo) { BitBucket::Repos.new }

  # class_eval is setting global variables in api.rb, this is creating
  # failed expectations when these variables are not reset to nil before
  # the next test is run. Therefore we must clear them manually as
  # for the user attribute below...
  after do
    repo.clear_user
  end

  describe '.create' do
    before do
      expect(repo).to receive(:request).with(
        :post,
        '/1.0/repositories/',
        BitBucket::Repos::DEFAULT_REPO_OPTIONS.merge({ 'owner' => 'mock_owner', 'name' => 'mock_repo' }),
        {}
      )
    end

    it 'should send a POST request to create the repo' do
      repo.create({ 'owner' => 'mock_owner', 'name' => 'mock_repo' })
    end
  end

  # TODO: fix case where block_given? returns true
  describe '.branches' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/branches/',
        {},
        {}
      )
    end

    it 'invokes the .request method' do
      repo.branches('mock_username', 'mock_repo')
    end
  end

  describe '.edit' do
    before do
      expect(repo).to receive(:request).with(
        :put,
        '/1.0/repositories/mock_username/mock_repo/',
        BitBucket::Repos::DEFAULT_REPO_OPTIONS.merge({ 'owner' => 'mock_owner' }),
        {}
      )
    end

    it 'should send a PUT request for the given repo' do
      repo.edit('mock_username', 'mock_repo', { 'owner' => 'mock_owner' })
    end
  end

  # TODO: make sure this gets documented in gem since it is not in official docs
  describe '.get' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo',
        {},
        {}
      )
    end

    it 'should send a GET request for the given repo' do
      repo.get('mock_username', 'mock_repo', {})
    end
  end

  describe '.list' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/user/repositories',
        {},
        {}
      )
    end

    # FIXME: this method belongs in the User class!
    it 'should send a GET request for the authenticated users repos' do
      repo.list
    end
  end

  describe '.tags' do
    before do
      expect(repo).to receive(:request).with(
        :get,
        '/1.0/repositories/mock_username/mock_repo/tags/',
        {},
        {}
      )
    end

    it 'should send a GET request for the tags belonging to the given repo' do
      repo.tags('mock_username', 'mock_repo')
    end
  end
end
