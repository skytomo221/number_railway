# frozen_string_literal: true

# 自然数鉄道のための名前空間
module NumberRailway
  # 駅間の線路を表すクラス
  # @attr_reader [Station] smaller 番号が小さい方の駅
  # @attr_reader [Station] greater 番号が大きい方の駅
  class Railway
    attr_reader :smaller, :greater

    # 新しい辺を生成します
    # newメソッドのエイリアスです
    # @param [Station] node1 駅
    # @param [Station] node2 駅
    def self.[](node1, node2)
      new(node1, node2)
    end

    # 新しい辺を生成します
    # @param [Station] node1 駅
    # @param [Station] node2 駅
    def initialize(node1, node2)
      @smaller, @greater = [node1, node2].minmax
    end

    # 他の線路と等しいかどうかを判定します
    # @param [Railway] other 比較対象の線路
    # @return [Boolean] 等しい場合は真を返す
    def ==(other)
      smaller == other.smaller && greater == other.greater
    end

    # 他の線路と等しいかどうかを判定します
    # @param [Railway] other 比較対象の線路
    # @return [Boolean] 等しい場合は真を返す
    def eql?(other)
      self == other
    end

    # ハッシュ値を返します
    # @return [Integer] ハッシュ値
    def hash
      [smaller, greater].hash
    end

    # 路線を返します
    # @return [Integer] 路線
    def line
      greater.to_i - smaller.to_i
    end
  end
end
