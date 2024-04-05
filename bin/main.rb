# frozen_string_literal: true

require "ruby-graphviz"

START = 111
GOAL = 999

class Integer # rubocop:disable Style/Documentation
  def divisors
    (1..self).select { |neighbor| (self % neighbor).zero? }
  end

  def divisors_with_negative
    divisors.map(&:-@).reverse + divisors
  end
end

# A class to represent an undirected edge
class UndirectedEdge
  attr_reader :smaller, :greater

  def initialize(node1, node2)
    @smaller, @greater = [node1, node2].sort
  end

  def ==(other)
    smaller == other.smaller && greater == other.greater
  end

  def eql?(other)
    self == other
  end

  def hash
    [smaller, greater].hash
  end

  def distance
    greater - smaller
  end
end

def shortest_depth(start, goal, max_depth = goal - start)
  return 0 if start == goal
  return if max_depth.zero?

  mut_max_depth = max_depth
  start.divisors.reverse.map do |distance|
    return 1 if start + distance == goal
    next if start + distance > goal

    shortest = shortest_depth(start + distance, goal, mut_max_depth - 1)
    shortest && mut_max_depth = shortest + 1
  end.reject(&:nil?).min
end

def shortest_paths_recursive(start, goal, max_depth, distance, depth)
  return Set[] if start + distance > goal

  paths = shortest_paths(start + distance, goal, max_depth, depth + 1)
  paths.empty? ? Set[] : paths.add(UndirectedEdge.new(start, start + distance))
end

def shortest_paths(start, goal, max_depth, depth = 0)
  return Set[] if max_depth < depth

  start.divisors.reverse.map do |distance|
    return Set[UndirectedEdge.new(start, goal)] if start + distance == goal

    shortest_paths_recursive(start, goal, max_depth, distance, depth)
  end.to_set.flatten
end

graphviz = GraphViz.new(:G, type: :graph, layout: :dot)
sd = shortest_depth(START, GOAL)
puts "Shortest depth: #{sd}"
shortest_paths(START, GOAL, sd).each do |e|
  graphviz.add_edges(e.smaller.to_s, e.greater.to_s, label: e.distance.to_s)
end

graphviz.output(png: "sample.png")
