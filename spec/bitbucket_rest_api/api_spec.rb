require 'spec_helper'

describe BitBucket::API do
  let(:setup_options) { { user: 'test_user' } }
  let(:bitbucket_api) { described_class.new(setup_options) }

  describe '#new' do
    it 'passes options to bitbucket' do
      mock_options = double
      setup_options = {}
      mock_options.expects(:merge).with(setup_options).returns(setup_options)
      BitBucket.expects(:options).returns(mock_options)

      described_class.new(setup_options)

      BitBucket.unstub(:options)
    end

    context 'valid options' do
      it 'sets valid options' do
        setup_options = {
          login: 'johnwick',
          password: 'password'
        }
        bitbucket_api = described_class.new(setup_options)

        expect(bitbucket_api.login).to eq('johnwick')
        expect(bitbucket_api.password).to eq('password')
      end

      it 'ignores invalid options' do
        setup_options = {
          invalid_option: 'invalid option'
        }

        bitbucket_api = described_class.new(setup_options)

        expect{ bitbucket_api.invalid_option }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#method_missing' do
    let(:setup_options) { {user: 'test_user'} }

    it 'responds to attribute query' do
      expect(bitbucket_api.user?).to eq(true)
    end

    it 'clears the attributes' do
      bitbucket_api.clear_user

      expect(bitbucket_api.user).to be_nil
    end
  end

  describe '#_update_user_repo_params' do
    it 'sets the username and repo_name' do
      bitbucket_api._update_user_repo_params('test_user1', 'test_repo')

      expect(bitbucket_api.user).to eq('test_user1')
      expect(bitbucket_api.repo).to eq('test_repo')
    end
  end

  describe '#_merge_user_into_params!' do
    let(:params) { {} }

    it 'takes a hash and merges user into it' do
      bitbucket_api._merge_user_into_params!(params)

      expect(params).to include('user')
    end
  end

  describe '#_merge_user_repo_into_params!' do
    let(:params) { {} }

    it 'takes a hash and merges user into it' do
      new_params = bitbucket_api._merge_user_repo_into_params!(params)

      expect(new_params).to include('user')
      expect(new_params).to include('repo')
    end
  end
end
