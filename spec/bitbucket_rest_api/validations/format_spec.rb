require 'spec_helper'

describe BitBucket::Validations::Format do
  let(:format) { Class.new.extend(described_class) }
  before do
    @permitted = {"param1" => ["val1", "val2"], "param2" => /^regexp$/}
  end

  describe ".assert_valid_values" do
    it "raises an UnknownValue error when provided an unpermitted parameter" do
      params = {"param1" => "unpermitted_value"}
      expect{
        format.assert_valid_values(@permitted, params)
        }.to raise_error BitBucket::Error::UnknownValue

      params = {"param2" => "unpermitted_value"}
      expect{
        format.assert_valid_values(@permitted, params)
        }.to raise_error BitBucket::Error::UnknownValue
    end

    it "returns the params when provided with only permitted parameters" do
      params = {"param1" => "val1", "param2" => "regexp"}
      expect(
        format.assert_valid_values(@permitted, params)
        ).to eq({"param1" => "val1", "param2" => "regexp"})
    end
  end
end
