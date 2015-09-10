require 'terminal-table'
require 'byebug'

class MyHash
  attr_accessor :grid
  
  def initialize
    self.grid = populate_grid
  end
  
  def check_neighbours(coord)
    if all_water_cells?(coord)
      :all_water
    else
      :ships_around
    end
  end
  
  
  def populate_grid
    grid = {}
    [*'A'..'J'].each do |l|
      [*1..10].each do |n|
       grid["#{l}#{n}".to_sym] = 'w'
      end
    end
    grid
  end
  
  def draw_grid
    rows = get_grid_values
    table = Terminal::Table.new :headings => ['', *'1'..'10'], :rows => rows
    table.render
  end
  
  def get_grid_values
    grid_values = []
    [*'A'..'J'].each do |letter|
      row_hash = self.grid.select { |key, value| key.to_s.match(letter) }
      arr = ["#{letter}"]
      arr.push(row_hash.values)
      grid_values.push(arr.flatten)
    end
    grid_values
  end  
  
  def place_ship(coord)
    if self.grid[coord] == 'w'
      self.grid[coord] = 's'
    else
      'can not do that'
    end
  end
  
  def all_water_cells?(coord)
    right_n = get_right_n_coord(coord)
    left_n = get_left_n_coord(coord)
    self.grid[right_n] == 'w' && self.grid[left_n] == 'w'
  end
  
  def get_coord(coord, direction)
    #get_coord(:A1, :down)
    method_to_run = self.method("get_#{direction}_n_coord".to_sym)
    method_to_run.call coord
  end
  
  def get_right_n_coord(coord)
    #byebug
    l = (coord[0].codepoints.first + 1).chr 
    coord.to_s.gsub(coord[0],l).to_sym
  end
  
  def get_left_n_coord(coord)
    l = (coord[0].codepoints.first - 1).chr 
    coord.to_s.gsub(coord[0],l).to_sym
  end
  
  def get_down_n_coord(coord)
    #byebug
    n = coord[1,2].next
    coord.to_s.gsub(coord[1,2],n).to_sym
  end
  
  def get_up_n_coord(coord)
    #byebug
    n = (coord[1,2].to_i) -1
    coord.to_s.gsub(coord[1,2],n.to_s).to_sym
  end
  
end