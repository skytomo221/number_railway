# frozen_string_literal: true

module NumberRailway
  # 路線を表すクラス
  class Line
    # 新しい路線を生成します
    # newメソッドのエイリアスです
    # @param [Array<Station>] line 路線
    def self.[](line)
      new(line)
    end

    # 新しい路線を生成します
    def initialize(line)
      @line = line
    end

    # 他の路線と等しいかどうかを判定します
    def ==(other)
      @line == other.to_i
    end

    # 他の路線と等しいかどうかを判定します
    def eql?(other)
      self == other
    end

    # ハッシュ値を返します
    def hash
      @line.hash
    end

    # 路線の番号を文字列に変換します
    # @return [String] 駅の番号を表す文字列
    def to_s
      @line.to_s
    end

    # 路線の番号を整数に変換します
    # @return [Integer] 駅の番号
    def to_i
      @line
    end

    # 駅が路線に含まれるかどうかを判定します
    # @param [Station] station 駅
    # @return [Boolean] 含まれる場合は真を返す
    def stop?(station)
      @line.include?(station)
    end
  end
end
