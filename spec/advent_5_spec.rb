def find_password_for_part_one(door_id)
  index = 0
  password = ''
  password_length = 8

  while password.length < password_length
    next_hash = Digest::MD5.hexdigest("#{door_id}#{index}")
    if next_hash.start_with?('00000')
      password += next_hash[5]
    end
    index += 1
  end
  password
end

def find_password_for_part_two(door_id)
  index = 0
  password_length = 8
  password = ' ' * password_length

  while letters_missing?(password)
    next_hash = Digest::MD5.hexdigest("#{door_id}#{index}")
    if next_hash.start_with?('00000') && valid_index?(next_hash[5])
      password_index = next_hash[5].to_i
      if password[password_index] == ' '
        password[password_index] = next_hash[6]
      end
    end
    index += 1
  end
  password
end

def valid_index?(index)
  integer?(index) && index.to_i < 8
end

def integer?(i)
  i.to_i.to_s == i
end

def letters_missing?(password)
  if /\S{8}/ =~ password
    false
  else
    true
  end
end

describe 'Advent of code - Day 5' do
  it 'finds password for part one' do
    expect(find_password_for_part_one('abc')).to eq('18f47a30')
  end

  it 'finds password for my input' do
    p find_password_for_part_one('abbhdwsy')
  end

  it 'not all letters found' do
    expect(letters_missing?('        ')).to eq(true)
  end

  it 'all letters found' do
    expect(letters_missing?('aaaaaaaa')).to eq(false)
  end

  it 'finds a password for part two' do
    expect(find_password_for_part_two('abc')).to eq('05ace8e3')
  end

  it 'finds for input on part two' do
    p find_password_for_part_two('abbhdwsy')
  end
end
