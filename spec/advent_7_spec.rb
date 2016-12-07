def count_valid_addresses(addresses)
  addresses.reduce(0) do |count, address|
    if !palindome_exists_in_square_brackets?(address) && palindome_exists_outside_square_brackets?(address)
      count += 1
    end
    count
  end
end

def palindome_exists_outside_square_brackets?(address)
  match = /(\w+)\[/.match(address) || /\](\w+)/.match(address)
  if match.nil?
    false
  else
    captured = match.captures.first

    four_char_palindrome?(captured) || palindome_exists_outside_square_brackets?(address[match.end(0)..-1])
  end
end

def palindome_exists_in_square_brackets?(address)
  match = /\[(\w+)\]/.match(address)
  if match.nil?
    false
  else
    inside_brackets = match.captures.first

    four_char_palindrome?(inside_brackets) || palindome_exists_in_square_brackets?(address[match.end(0)..-1])
  end
end

def four_char_palindrome?(letters)
  number_of_letters = letters.length - 4
  (0..number_of_letters)
    .map { |index| letters[index..index+3] }
    .any? { |token| token[0] == token[3] && token[1] == token[2] && token[0] != token[1] }
end

describe 'Advent of code - Day 7' do
  it 'address does not support TLS' do
    expect(palindome_exists_in_square_brackets?('abcd[bddb]xyyx')).to be true
  end

  it 'address with multiple square brackets not support TLS' do
    expect(palindome_exists_in_square_brackets?('abcd[addb]xyyx[abba]foo')).to be true
  end

  it 'no palindrome exists within square brackets' do
    expect(palindome_exists_in_square_brackets?('abba[mnop]qrst')).to be false
  end

  it 'palindrome exists outside square brackets' do
    expect(palindome_exists_outside_square_brackets?('abba[mnop]qrst')).to be true
  end

  it 'palindrome exists after square brackets' do
    expect(palindome_exists_outside_square_brackets?('abbc[mnop]abba')).to be true
  end

  it 'is a four character palindrome' do
    expect(four_char_palindrome?('abba')).to be true
  end

  it 'is not a four character palindrome' do
    expect(four_char_palindrome?('mnop')).to be false
  end

  it 'is not a four character palindrome when all the same' do
    expect(four_char_palindrome?('aaaa')).to be false
  end

  it 'counts number of valid addresses' do
    p count_valid_addresses(File.read('./spec/advent_7_input').split("\n"))
  end
end
