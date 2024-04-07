# frozen_string_literal: true

require_relative "number_railway/version"

# 自然数を表す整数の拡張
class Integer
  # 正の数の約数のみを列挙します
  # @return [Array<Integer>] 正の数の約数の配列
  # @example 42の正の約数を列挙する
  #   42.positive_divisors #=> [1, 2, 3, 6, 7, 14, 21, 42]
  # @example 221の正の約数を列挙する
  #   221.positive_divisors #=> [1, 13, 17, 221]
  def positive_divisors
    (1..self).select { |neighbor| (self % neighbor).zero? }
  end

  # 負の約数も含めた約数を列挙します
  # @return [Array<Integer>] 正負の約数の配列
  # @example 42の約数を列挙する
  #   42.divisors #=> [-42, -21, -14, -7, -6, -3, -2, -1, 1, 2, 3, 6, 7, 14, 21, 42]
  # @example 221の約数を列挙する
  #   221.divisors #=> [-221, -17, -13, -1, 1, 13, 17, 221]
  def divisors
    positive_divisors.map(&:-@).reverse + positive_divisors
  end
end

# 自然数鉄道のモジュール
module NumberRailway
  require_relative "number_railway/line"
  require_relative "number_railway/station"
  require_relative "number_railway/railway"
end
