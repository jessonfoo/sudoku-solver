class Sudoku
  THE_NUMBERS_ONE_THROUGH_NINE = (1..9).to_a
  def initialize(board_string)
    @board = board_string.split('').map {|value| Cell.new(value)}
  end

  def solve!
    while there_are_still_empty_cells?
      @board.each_with_index do |cell, index|
        next unless cell.is_empty?
        existing_numbers = get_row_for(index) + get_column_for(index) + get_box_for(index)
        possibilities = THE_NUMBERS_ONE_THROUGH_NINE - existing_numbers
        if there_is_only_one possibilities
          cell.write possibilities
        end
      end
    end
  end

  def board
    puts @board.map(&:value).inspect
  end

  private
  def get_row_for index
    @board.each_slice(9).to_a[index / 9].map(&:value)
  end

  def get_column_for index
    @board.each_slice(9).to_a.transpose[index % 9].map(&:value)
  end

  def get_box_for index
    box = []
    @board.each_with_index do |cell, cell_index|
      if (index / 9) / 3 == (cell_index / 9) / 3 && (index % 9) / 3 == (cell_index % 9) / 3
        box.push cell.value
      end
    end
    box
  end

  def there_is_only_one possibilities
    possibilities.length == 1
  end

  def there_are_still_empty_cells?
    @board.any? {|cell| cell.is_empty?}
  end
end

class Cell
  attr_reader :value
  def initialize value
    @value = value.to_i
  end

  def write possibilities
    @value = possibilities[0]
  end

  def is_empty?
    @value == 0
  end
end

sudoku = Sudoku.new("619030040270061008000047621486302079000014580031009060005720806320106057160400030")
sudoku.solve!
puts sudoku.board
