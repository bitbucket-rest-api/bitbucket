require 'spec_helper'

describe BitBucket::Authorization do
  let(:oauth_api) { BitBucket::API.new(oauth_token: 'example_oauth_token') }
  let(:basic_auth_api) { BitBucket::API.new(basic_auth: 'example_login:example_password') }
  let(:basic_auth_api_hash) do
    BitBucket::API.new(
      basic_auth: { login: 'example_login', password: 'example_password' })
  end
  let(:login_and_password_api) do
    BitBucket::API.new(
      login:      'example_login',
      password:   'example_password',
      basic_auth: nil
    )
  end

  describe '#authenticated?' do
    context 'oauth authentication' do
      it 'should return true if oauth is used' do
        expect(oauth_api.authenticated?).to eq(true)
      end
    end

    context 'basic authentication' do
      it 'should return true if basic authentication is used' do
        expect(basic_auth_api.authenticated?).to eq(true)
      end
    end
  end

  describe '#basic_authed?' do
    context 'with basic_auth' do
      it 'should return true if basic_auth is set' do
        expect(basic_auth_api.basic_authed?).to eq(true)
        expect(basic_auth_api_hash.basic_authed?).to eq(true)
      end
    end

    context 'with login and password' do
      it 'should return true if a login and password are set' do
        expect(login_and_password_api.basic_authed?).to eq(true)
      end
    end
  end

  describe '#authentication' do
    context 'with basic_auth as a string' do
      it 'should return a hash containing the value for :basic_auth' do
        expectation = { basic_auth: 'example_login:example_password' }

        expect(basic_auth_api.authentication).to eq(expectation)
      end
    end

    context 'with basic_auth as a hash' do
      it 'should return a hash containing the value for :basic_auth' do
        expectation = { basic_auth: { login: 'example_login', password: 'example_password'} }

        expect(basic_auth_api_hash.authentication).to eq(expectation)
      end
    end

    context 'with login and password' do
      it 'should return a hash containing values for :login and :password' do
        expectation = { login: 'example_login', password: 'example_password' }

        expect(login_and_password_api.authentication).to eq(expectation)
      end
    end
  end
end
