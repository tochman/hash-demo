require 'my_hash'
require 'byebug'

describe MyHash do
  
  subject { MyHash.new }
  
  it {is_expected.to respond_to :grid}
  it {is_expected.to respond_to :grid=}
  it {is_expected.to respond_to :populate_grid}
  it {is_expected.to respond_to :check_neighbours}
  it {is_expected.to respond_to :draw_grid}
  
  it 'grid is a hash' do
    expect(subject.grid).to be_kind_of Hash
  end
  
  it 'grid is populated with coodinate keys' do
    [*:A..:J].each do |k|
      [*1..10].each do |v|
        key = [k, v].join('')
        expect(subject.grid).to include key.to_sym
      end
    end
  end
  
  
  it 'grid coodinate keys are set to water' do
    [*:A..:J].each do |k|
      [*1..10].each do |v|
        key = [k, v].join('')
        expect(subject.grid[key.to_sym]).to eq 'w'
      end
    end
  end
  
  it 'checks for ships in neighbour cells' do
    expect(subject.check_neighbours(:B1)).to eq :all_water
  end
  
  it 'draws a table' do

    actual_table = "
    +---+---+---+---+---+---+---+---+---+---+----+
    |   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
    +---+---+---+---+---+---+---+---+---+---+----+
    | A | w | w | w | w | w | w | w | w | w | w  |
    | B | w | w | w | w | w | w | w | w | w | w  |
    | C | w | w | w | w | w | w | w | w | w | w  |
    | D | w | w | w | w | w | w | w | w | w | w  |
    | E | w | w | w | w | w | w | w | w | w | w  |
    | F | w | w | w | w | w | w | w | w | w | w  |
    | G | w | w | w | w | w | w | w | w | w | w  |
    | H | w | w | w | w | w | w | w | w | w | w  |
    | I | w | w | w | w | w | w | w | w | w | w  |
    | J | w | w | w | w | w | w | w | w | w | w  |
    +---+---+---+---+---+---+---+---+---+---+----+
    "
    
    expect(subject.draw_grid).to match actual_table
  end
  
  it 'places a ship on specific coordinate' do
    subject.place_ship(:G1)
    expect(subject.grid[:G1]).to eq 's' 
  end
  
  it 'does not plac a ship on specific coordinate if not water' do
    subject.grid[:E1] = 's'
    expect(subject.place_ship(:E1)).to eq 'can not do that' 
  end
  
  it 'fetches the coordinate to the left' do
    expect(subject.get_left_n_coord(:C3)).to eq :B3
  end
  
  it 'fetches the coordinate to the right' do
    expect(subject.get_right_n_coord(:C3)).to eq :D3
  end
  
  it 'fetches the coordinate above' do
    expect(subject.get_up_n_coord(:C3)).to eq :C2
  end
  
  it 'fetches the coordinate below' do
    expect(subject.get_down_n_coord(:C3)).to eq :C4
  end
end