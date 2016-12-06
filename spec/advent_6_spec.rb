def decode_words_part_one(words)
  word_size = words.first.length
  (0...word_size).reduce('') do |result, letter_number|
    letters_to_compare = words.map { |w| w[letter_number] }
    result + most_common(letters_to_compare)
  end
end

def most_common(letters)
  frequency_table = letters.inject(Hash.new(0)) do |result,letter|
    result[letter] += 1
    result
  end

  letters.max_by { |letter| frequency_table[letter] }
end

def decode_words_part_two(words)
  word_size = words.first.length
  (0...word_size).reduce('') do |result, letter_number|
    letters_to_compare = words.map { |w| w[letter_number] }
    result + min_common(letters_to_compare)
  end
end

def min_common(letters)
  frequency_table = letters.inject(Hash.new(0)) do |result,letter|
    result[letter] += 1
    result
  end

  letters.min_by { |letter| frequency_table[letter] }
end

def read_input(filename)
  File.read(filename)
      .split("\n")
end

describe 'Advent of code - Day 6' do
  it 'decodes first letter' do
    expect(decode_words_part_one(['a', 'a', 'a'])).to eq('a')
  end

  it 'decodes word' do
    expect(decode_words_part_one(['easter', 'eastea', 'aastea'])).to eq('eastea')
  end

  it 'decodes another word for part one' do
    input = ['eedadn',
        'drvtee',
        'eandsr',
        'raavrd',
        'atevrs',
        'tsrnev',
        'sdttsa',
        'rasrtv',
        'nssdts',
        'ntnada',
        'svetve',
        'tesnvt',
        'vntsnd',
        'vrdear',
        'dvrsen',
        'enarar']
    expect(decode_words_part_one(input)).to eq('easter')
  end

  it 'decodes another word for part two' do
    input = ['eedadn',
             'drvtee',
             'eandsr',
             'raavrd',
             'atevrs',
             'tsrnev',
             'sdttsa',
             'rasrtv',
             'nssdts',
             'ntnada',
             'svetve',
             'tesnvt',
             'vntsnd',
             'vrdear',
             'dvrsen',
             'enarar']
    expect(decode_words_part_two(input)).to eq('advent')
  end

  it 'decodes part one' do
    p decode_words_part_one(read_input('./spec/advent6_input'))
  end

  it 'decodes part two' do
    p decode_words_part_two(read_input('./spec/advent6_input'))
  end
end
