# frozen_string_literal: true

require "color"
require "ruby-graphviz"

START = 1
GOAL = 94

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
  start.divisors_with_negative.reverse.map do |distance|
    return 1 if start + distance == goal
    next if start + distance > goal * 2

    shortest = shortest_depth(start + distance, goal, mut_max_depth - 1)
    shortest && mut_max_depth = shortest + 1
  end.reject(&:nil?).min
end

def shortest_paths_recursive(start, goal, max_depth, distance)
  return Set[] if start + distance > goal * 2

  paths = shortest_paths(start + distance, goal, max_depth - 1)
  paths.empty? ? Set[] : paths.add(UndirectedEdge.new(start, start + distance))
end

def shortest_paths(start, goal, max_depth)
  return Set[] if max_depth.zero?

  start.divisors_with_negative.reverse.map do |distance|
    return Set[UndirectedEdge.new(start, goal)] if start + distance == goal

    shortest_paths_recursive(start, goal, max_depth, distance)
  end.to_set.flatten
end

graphviz = GraphViz.new(:G, type: :graph, layout: :dot)
start, goal = [START, GOAL].minmax
sd = shortest_depth(start, goal)
puts "Shortest depth: #{sd}"
results = shortest_paths(start, goal, sd)

def node_color(node)
  start, goal = [START, GOAL].minmax
  hue = (node - start) / (goal - start).to_f * 300
  Color::HSL.new(hue, 90, 45).to_rgb.html
end

MAX_LINE = results.to_a.max { |a, b| a.distance <=> b.distance }
MIN_LINE = results.to_a.min { |a, b| a.distance <=> b.distance }

def line_color(line)
  start, goal = [START, GOAL].minmax
  hue = (line - MIN_LINE.distance) / (goal - start).to_f * 300
  Color::HSL.new(hue, 90, 45).to_rgb.html
end

results.each do |e|
  graphviz.add_nodes(e.smaller.to_s, color: node_color(e.smaller), penwidth: 3)
  graphviz.add_nodes(e.greater.to_s, color: node_color(e.greater), penwidth: 3)
  graphviz.add_edges(e.smaller.to_s, e.greater.to_s, label: e.distance.to_s, color: line_color(e.distance), penwidth: 3)
end

START_AND_GOAL_COLOR = Color::HSL.new(300, 90, 72.5).to_rgb.html

graphviz.add_nodes(start.to_s, color: node_color(start), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)
graphviz.add_nodes(goal.to_s, color: node_color(goal), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)

graphviz.output(png: "sample.png")

# puts((1..100).filter { |i| i % 4 == 1 }.map do |i|
#   j = i + 4

#   "[#{i}, #{j}, #{shortest_depth(i, j) || 0}]"
# end.join(", "))
