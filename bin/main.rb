# frozen_string_literal: true

require "color"
require "prime"
require "ruby-graphviz"
require "number_railway"

include NumberRailway # rubocop:disable Style/MixinUsage

START = 122
GOAL = 132

graphviz = GraphViz.new(:G, type: :graph, layout: :dot)
start, goal = [Station[START], Station[GOAL]].minmax
sd = start.distance(goal)
puts "Shortest depth: #{sd}"
results = start.paths(goal, sd)

def node_color(node)
  start, goal = [Station[START], Station[GOAL]].minmax
  hue = (node.to_i - start.to_i) / (goal.to_i - start.to_i).to_f * 300
  Color::HSL.new(hue, 90, 45).to_rgb.html
end

MAX_LINE = results.max_by(&:line).line
MIN_LINE = results.min_by(&:line).line

def line_color(line)
  hue = (line - MIN_LINE) / (MAX_LINE - MIN_LINE).to_f * 300
  Color::HSL.new(hue, 90, 45).to_rgb.html
end

results.each do |e|
  graphviz.add_nodes(e.smaller.to_s, color: node_color(e.smaller), penwidth: 3)
  graphviz.add_nodes(e.greater.to_s, color: node_color(e.greater), penwidth: 3)
  graphviz.add_edges(e.smaller.to_s, e.greater.to_s, label: e.line.to_s, color: line_color(e.line), penwidth: 3)
end

START_AND_GOAL_COLOR = Color::HSL.new(300, 90, 72.5).to_rgb.html

graphviz.add_nodes(start.to_s, color: node_color(start), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)
graphviz.add_nodes(goal.to_s, color: node_color(goal), fillcolor: START_AND_GOAL_COLOR, style: :filled, penwidth: 3)

graphviz.output(png: "sample.png")
