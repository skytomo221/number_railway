# frozen_string_literal: true

RSpec.describe NumberRailway do
  describe Integer do
    describe "#positive_divisors" do
      it "returns an array of positive divisors" do
        expect(42.positive_divisors).to eq([1, 2, 3, 6, 7, 14, 21, 42])
        expect(221.positive_divisors).to eq([1, 13, 17, 221])
      end
    end

    describe "#divisors" do
      it "returns an array of positive and negative divisors" do
        expect(42.divisors).to eq([-42, -21, -14, -7, -6, -3, -2, -1, 1, 2, 3, 6, 7, 14, 21, 42])
        expect(221.divisors).to eq([-221, -17, -13, -1, 1, 13, 17, 221])
      end
    end
  end
end
