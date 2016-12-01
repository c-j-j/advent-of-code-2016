class SpaceShip
  attr_reader :x, :y, :direction, :visited

  def initialize
    @x = 0
    @y = 0
    @direction = :north
    @visited = []
  end

  def make_moves!(commands)
    commands.split(', ').each { |c| move!(c) }
  end

  def move!(single_move)
    direction = single_move[0]
    distance = single_move[1..-1].to_i

    case direction
    when 'R'
      rotate_right!
    when 'L'
      rotate_left!
    end

    move_distance!(distance)
  end

  def find_places_visited_twice
    @visited.select do |visit|
      @visited.count(visit) > 1
    end
  end

  def distance_to_visited_location
    visit_twice = find_places_visited_twice.first

    visit_twice[0].abs + visit_twice[1].abs
  end

  def distance_away
    @x.abs + @y.abs
  end

  def move_distance!(distance)
    case @direction
    when :north
      move_y_by_distance!(distance)
    when :east
      move_x_by_distance!(distance)
    when :south
      move_y_by_distance!(-distance)
    when :west
      move_x_by_distance!(-distance)
    end
  end

  def move_y_by_distance!(distance)
    distance.abs.times do
      if distance > 0
        @y += 1
      else
        @y -= 1
      end
      @visited << [@x, @y]
    end
  end

  def move_x_by_distance!(distance)
    distance.abs.times do
      if distance > 0
        @x += 1
      else
        @x -= 1
      end
      @visited << [@x, @y]
    end
  end

  def rotate_right!
    case @direction
    when :north
      @direction = :east
    when :east
      @direction = :south
    when :south
      @direction = :west
    when :west
      @direction = :north
    end
  end

  def rotate_left!
    case @direction
    when :north
      @direction = :west
    when :east
      @direction = :north
    when :south
      @direction = :east
    when :west
      @direction = :south
    end
  end
end

commands = "R2, L1, R2, R1, R1, L3, R3, L5, L5, L2, L1, R4, R1, R3, L5, L5, R3, L4, L4, R5, R4, R3, L1, L2, R5, R4, L2, R1, R4, R4, L2, L1, L1, R190, R3, L4, R52, R5, R3, L5, R3, R2, R1, L5, L5, L4, R2, L3, R3, L1, L3, R5, L3, L4, R3, R77, R3, L2, R189, R4, R2, L2, R2, L1, R5, R4, R4, R2, L2, L2, L5, L1, R1, R2, L3, L4, L5, R1, L1, L2, L2, R2, L3, R3, L4, L1, L5, L4, L4, R3, R5, L2, R4, R5, R3, L2, L2, L4, L2, R2, L5, L4, R3, R1, L2, R2, R4, L1, L4, L4, L2, R2, L4, L1, L1, R4, L1, L3, L2, L2, L5, R5, R2, R5, L1, L5, R2, R4, R4, L2, R5, L5, R5, R5, L4, R2, R1, R1, R3, L3, L3, L4, L3, L2, L2, L2, R2, L1, L3, R2, R5, R5, L4, R3, L3, L4, R2, L5, R5"
spaceship = SpaceShip.new
spaceship.make_moves!(commands)

puts(spaceship.distance_away)
puts(spaceship.distance_to_visited_location)

