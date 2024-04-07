# frozen_string_literal: true

module NumberRailway
  # 自然数鉄道の駅を表すクラス
  class Station
    include Comparable

    # 新しい駅を生成します
    # newメソッドのエイリアスです
    # @param [Integer] number 駅の番号
    def self.[](number)
      new(number)
    end

    # @param [Integer] number 駅の番号
    def initialize(number)
      @number = number
    end

    # 他の駅と等しいかどうかを判定します
    # @param [Station] other 比較対象の駅
    # @return [Boolean] 等しい場合は真を返す
    def ==(other)
      @number == other.to_i
    end

    # 他の駅と等しいかどうかを判定します
    # @param [Station] other 比較対象の駅
    # @return [Boolean] 等しい場合は真を返す
    def eql?(other)
      self == other
    end

    # ハッシュ値を返します
    # @return [Integer] ハッシュ値
    def hash
      @number.hash
    end

    # 駅の番号を文字列に変換します
    # @return [String] 駅の番号を表す文字列
    def to_s
      @number.to_s
    end

    # 駅の番号を整数に変換します
    # @return [Integer] 駅の番号
    def to_i
      @number
    end

    # 駅の番号を比較します
    # @param [Station] other 比較対象の駅
    # @return [Integer] 比較結果
    def <=>(other)
      @number <=> other.to_i
    end

    # 駅の路線のリストを返します
    # @return [Array<Line>] 駅の路線のリスト
    def lines
      @number.positive_divisors
             .map { |divisor| Line[divisor] }
    end

    # 駅が路線に含まれるかどうかを判定します
    # @param [Line] line 路線
    # @return [Boolean] 含まれる場合は真を返す
    def stop?(line)
      line.stop?(self)
    end

    # 駅の番号が正の数かどうかを判定します
    # @return [Boolean] 正の数の場合は真を返す
    def positive?
      @number.positive?
    end

    # 駅の隣接駅のリストを返します
    # @return [Array<Station>] 駅の隣接駅のリスト
    def neighbors
      @number.divisors
             .map { |divisor| Station[@number + divisor] }
             .filter(&:positive?)
    end

    # 駅が隣接駅かどうかを判定します
    # @param [Station] station 隣接駅
    def neighbor?(station)
      @number.divisors.include?(station.to_i - @number)
    end

    # 駅の隣接駅との辺のリストを返します
    # @return [Array<Railway>] 駅の隣接駅との辺のリスト
    def railways
      neighbors.map { |neighbor| Railway[self, neighbor] }
    end

    # 駅までの最短距離を返します
    # @param [Station] goal 目的地
    # @param [Integer] longest 最大距離
    # @return [Integer, nil] 最短距離
    def distance(goal, longest = goal.to_i - @number)
      distance_fast(@number, goal.to_i, longest)
    end

    # 駅までの最短パスを返します
    # @param [Station] goal 目的地
    # @param [Integer] longest 最大距離
    # @return [Array<Station>, nil] 最短パス
    def routes(goal, longest = goal.to_i - @number)
      routes_fast(@number, goal.to_i, longest).flatten(longest - 1)
    end

    # 駅までの最短パスを返します
    # @param [Station] goal 目的地
    # @param [Integer] longest 最大距離
    # @return [Set<Railway>, nil] 最短パス
    def paths(goal, longest = goal.to_i - @number)
      paths_fast(@number, goal.to_i, longest)
    end
  end

  private

  # 数値の最短距離を返します
  def distance_fast(start, goal, longest = goal - start) # rubocop:disable Metrics/CyclomaticComplexity
    return 0 if start == goal
    return if longest.zero?

    mut_longest = longest
    start.divisors.reverse.map do |distance|
      return 1 if start + distance == goal
      next if start + distance > goal * 2

      shortest = distance_fast(start + distance, goal, mut_longest - 1)
      shortest && mut_longest = shortest + 1
    end.reject(&:nil?).min
  end

  # 数値の最短パスを返します
  def routes_fast(start, goal, longest = goal - start, paths = [start])
    return paths if start == goal
    return [] if longest.zero?

    start.divisors.reverse.map do |distance|
      next [] if start + distance > goal * 2

      routes_fast(start + distance, goal, longest - 1, [*paths, start + distance])
    end.reject(&:empty?)
  end

  def paths_recursive_fast(start, goal, max_depth, distance)
    return Set[] if start + distance > goal * 2

    paths = paths_fast(start + distance, goal, max_depth - 1)
    paths.empty? ? Set[] : paths.add(Railway.new(start, start + distance))
  end

  # 数値の最短パスを返します
  def paths_fast(start, goal, max_depth)
    return Set[] if max_depth.zero?

    start.divisors.reverse.map do |distance|
      return Set[Railway.new(start, goal)] if start + distance == goal

      paths_recursive_fast(start, goal, max_depth, distance)
    end.to_set.flatten
  end
end
