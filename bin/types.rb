# frozen_string_literal: true

require "number_railway"

include NumberRailway # rubocop:disable Style/MixinUsage

(1..1).map do |s|
  (s..3).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 1

    start, neighbor, goal = paths.first
    puts("I: #{{ start: s, goal: g, distance: d, paths: paths }}") if start < neighbor && neighbor < goal
  end
end

(1..2).map do |s|
  (s..6).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    if paths.all? { |start, neighbor, goal| start < neighbor && neighbor < goal }
      puts("O: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..3).map do |s|
  (s..5).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    if paths.any? { |start, neighbor, goal| start < neighbor && neighbor < goal } &&
       paths.any? { |_, neighbor, goal| neighbor > goal }
      puts("IJ: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..5).map do |s|
  (s..8).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 3

    next unless paths.any? { |start, neighbor, goal| start < neighbor && neighbor < goal } &&
                paths.any? { |_, neighbor, goal| neighbor > goal } &&
                paths.any? { |start, neighbor| start > neighbor }

    puts("IJT: #{{ start: s, goal: g, distance: d, paths: paths }}")
  end
end

(1..6).map do |s|
  (s..11).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 1

    _, neighbor, goal = paths.first
    puts("J: #{{ start: s, goal: g, distance: d, paths: paths }}") if neighbor > goal
  end
end

(1..7).map do |s|
  (s..9).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    if paths.any? { |start, neighbor, goal| start < neighbor && neighbor < goal } &&
       paths.any? { |start, neighbor| start > neighbor }
      puts("IT: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..8).map do |s|
  (s..15).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 3

    if paths.count { |start, neighbor, goal| start < neighbor && neighbor < goal } == 2 &&
       paths.count { |_, neighbor, goal| neighbor > goal } == 1
      puts("IIJ: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..8).map do |s|
  (s..18).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 3

    if paths.all? { |start, neighbor, goal| start < neighbor && neighbor < goal }
      puts("III: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..11).map do |s|
  (s..20).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    if paths.any? { |start, neighbor| start > neighbor } &&
       paths.any? { |_, neighbor, goal| neighbor > goal }
      puts("JT: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..13).map do |s|
  (s..18).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 1

    start, neighbor = paths.first
    puts("T (Tarned J): #{{ start: s, goal: g, distance: d, paths: paths }}") if start > neighbor
  end
end

(1..35).map do |s|
  (s..39).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 3

    if paths.count { |start, neighbor, goal| start < neighbor && neighbor < goal } == 1 &&
       paths.count { |_, neighbor, goal| neighbor > goal } == 2
      puts("IJJ: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..51).map do |s|
  (s..60).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 3

    if paths.count { |start, neighbor, goal| start < neighbor && neighbor < goal } == 1 &&
       paths.count { |start, neighbor| start > neighbor } == 2
      puts("ITT: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..54).map do |s|
  (s..84).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 4

    if paths.all? { |start, neighbor, goal| start < neighbor && neighbor < goal }
      puts("IIII: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end

(1..122).map do |s|
  (s..132).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    puts("TT: #{{ start: s, goal: g, distance: d, paths: paths }}") if paths.all? { |start, neighbor| start > neighbor }
  end
end

(1..132).map do |s|
  (s..142).map do |g|
    d = 2
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 2

    puts("JJ: #{{ start: s, goal: g, distance: d, paths: paths }}") if paths.all? { |_, neighbor, goal| neighbor > goal }
  end
end

(1..312).map do |s|
  (s..378).map do |g|
    d = 2
    next if g - s > 66 # 高速化のため
    next if Station[s].distance(Station[g], 2) != d

    paths = Station[s].routes(Station[g], d)
    next if paths.length != 5

    if paths.all? { |start, neighbor, goal| start < neighbor && neighbor < goal }
      puts("I5: #{{ start: s, goal: g, distance: d, paths: paths }}")
    end
  end
end
