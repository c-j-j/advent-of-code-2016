class NumberPad
  attr_reader :current_position

  MOVES = {
    '1' => {'D' => '3'},
    '2' => {'D' => '6', 'R' => '3'},
    '3' => {'D' => '7', 'U' => '1', 'L' => '2', 'R' => '4'},
    '4' => {'D' => '8', 'L' => '3'},
    '5' => {'R' => '6'},
    '6' => {'D' => 'A', 'L' => '5', 'U' => '2', 'R' => '7'},
    '7' => {'D' => 'B', 'L' => '6', 'U' => '3', 'R' => '8'},
    '8' => {'D' => 'C', 'L' => '7', 'U' => '4', 'R' => '9'},
    '9' => {'L' => '8'},
    'A' => {'U' => '6', 'R' => 'B'},
    'B' => {'D' => 'D', 'L' => 'A', 'U' => '7', 'R' => 'C'},
    'C' => {'L' => 'B', 'U' => '8'},
    'D' => {'U' => 'B'},
  }

  def press_buttons(starting_position, moves)
    moves.split('').reduce(starting_position) { |position, m| press_button(position, m) }
  end

  def press_button(position, direction)
    MOVES.fetch(position)
         .fetch(direction, position)
  end
end

class CodeCracker
  def crack(input)
    input.split("\n").reduce('') do |code, line|
      if code == ''
        NumberPad.new.press_buttons('5', line)
      else
        last_number = code[-1]
        number_pad = NumberPad.new
        "#{code}#{number_pad.press_buttons(last_number, line)}"
      end
    end
  end
end
