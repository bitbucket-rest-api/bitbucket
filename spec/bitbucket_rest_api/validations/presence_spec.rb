require 'spec_helper'

describe BitBucket::Validations::Presence do
  let(:presence_checker) { Class.new.extend(described_class) }

  describe "._validates_user_repo_params" do
    it 'raises an ArgumentError if user_name or repo_name is nil' do
      expect{presence_checker._validate_user_repo_params('username')}.to raise_error ArgumentError
    end
  end
end
