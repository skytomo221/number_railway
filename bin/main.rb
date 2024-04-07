# frozen_string_literal: true

require "color"
require "prime"
require "ruby-graphviz"

START = 11
GOAL = 20

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

# graphviz = GraphViz.new(:G, type: :graph, layout: :dot)
# start, goal = [START, GOAL].minmax
# sd = shortest_depth(start, goal)
# puts "Shortest depth: #{sd}"
# results = shortest_paths(start, goal, sd)

# def node_color(node)
#   start, goal = [START, GOAL].minmax
#   hue = (node - start) / (goal - start).to_f * 300
#   Color::HSL.new(hue, 90, 45).to_rgb.html
# end

# MAX_LINE = results.max_by(&:distance).distance
# MIN_LINE = results.min_by(&:distance).distance

# def line_color(line)
#   hue = (line - MIN_LINE) / (MAX_LINE - MIN_LINE).to_f * 300
#   Color::HSL.new(hue, 90, 45).to_rgb.html
# end

# results.each do |e|
#   graphviz.add_nodes(e.smaller.to_s, color: node_color(e.smaller), penwidth: 3)
#   graphviz.add_nodes(e.greater.to_s, color: node_color(e.greater), penwidth: 3)
#   graphviz.add_edges(e.smaller.to_s, e.greater.to_s, label: e.distance.to_s, color: line_color(e.distance), penwidth: 3)
# end

# START_AND_GOAL_COLOR = Color::HSL.new(300, 90, 72.5).to_rgb.html

# graphviz.add_nodes(start.to_s, color: node_color(start), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)
# graphviz.add_nodes(goal.to_s, color: node_color(goal), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)

# graphviz.output(png: "sample.png")

def shortest_paths2(start, goal, max_depth = goal - start, paths = [start])
  return paths if start == goal
  return [] if max_depth.zero?

  start.divisors_with_negative.reverse.map do |distance|
    next [] if start + distance > goal * 2

    shortest_paths2(start + distance, goal, max_depth - 1, [*paths, start + distance])
  end.reject(&:empty?)
end

def shortest_paths3(start, goal, max_depth = goal - start, paths = [start])
  shortest_paths2(start, goal, max_depth, paths).flatten(max_depth - 1)
end

(1..38).map do |s|
  (s..43).map do |g|
    d = shortest_depth(s, g)
    next if d != 2

    paths = shortest_paths3(s, g, d)
    next if paths.length != 1

    l, m, n = paths.first
    if n < m
      puts("✅ #{{ start: s, goal: g, distance: d, paths: paths }}")
    else
      puts("❌ #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

# (1..100).filter(&:prime?)
#         .map do |p|
#   (1..100).filter(&:prime?).map do |q|
#     s = p + 1
#     g = p + q
#     d = shortest_depth(s, g)
#     next if d != 2

#     paths = shortest_paths3(s, g, d)
#     next if paths.length != 1

#     l, m, n = paths.first
#     if m < l && l < n
#       puts("✅ #{{ start: s, goal: g, distance: d, paths: paths }}")
#     else
#       puts("❌ #{{ start: s, goal: g, distance: d, paths: paths }}")
#     end
#   end
# end
