require 'spec_helper'

describe BitBucket::Validations::Token do
  let(:token) { Class.new.extend(described_class) }

  describe ".validates_token_for" do
    it 'returns false if authentication token is not required' do
      token.validates_token_for(:get, '/anotherpath').should be false
    end

    it 'returns true if authentication token is required' do
      token.validates_token_for(:get, '/user').should be true
    end
  end
end
