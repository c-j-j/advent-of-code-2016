require 'advent1'

describe 'Advent of code' do
  it 'does not move' do
    space_ship = SpaceShip.new
    expect(space_ship.x).to eq(0)
    expect(space_ship.y).to eq(0)
    expect(space_ship.direction).to eq(:north)
  end

  it 'moves right and one' do
    space_ship = SpaceShip.new
    space_ship.move!("R1")
    expect(space_ship.x).to eq(1)
    expect(space_ship.y).to eq(0)
    expect(space_ship.direction).to eq(:east)
  end

  it 'makes many moves' do
    space_ship = SpaceShip.new
    space_ship.make_moves!("R2, L3")
    expect(space_ship.x).to eq(2)
    expect(space_ship.y).to eq(3)
  end

  it 'calculcates number of blocks away' do
    space_ship = SpaceShip.new
    space_ship.make_moves!("R2, L3")
    expect(space_ship.distance_away).to eq(5)
  end

  it 'finds duplicate location' do
    space_ship = SpaceShip.new
    space_ship.make_moves!("R8, R4, R4, R8")

    expect(space_ship.distance_to_visited_location).to eq(4)
  end
end
