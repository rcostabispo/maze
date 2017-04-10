require_relative "ui"

CHAR_HERO        = 'H'
CHAR_WALL        = '|'
CHAR_BARRIER     = '-'
CHAR_CORNER      = '+'
CHAR_STAR        = '0'
TOTAL_PERCENTAGE = 100
CMD_EXIT         = ['quit', 'q', 'exit']

def read_maze(filename)
  # MORE MAZES HERE:
  # http://www.delorie.com/game-room/mazes/genmaze.cgi
  #  Number of cells across (1..N): 14
  #  Number of cells up/down (1..N): 14
  File.read(filename).split("\n")
end

def find_gamer(maze)
  maze.each_with_index do |value, index|
    if (column = value.index(/#{CHAR_HERO}/))
      return [index, column]
    end
  end
end

def is_moves_valid?(maze, line, column)
  size_line   = maze.size
  size_column = maze.first.size
  if (line >= size_line || line < 0) || (column >= size_column || column < 0)
    return false
  end

  (maze[line][column] != CHAR_WALL) &&
  (maze[line][column] != CHAR_CORNER) &&
  (maze[line][column] != CHAR_BARRIER)
end

def next_coordinates(direction, line, column)
  case direction
  when 'w'
    line = line - 1
  when 'd'
    column = column + 1
  when 's'
    line = line + 1
  when 'a'
    column = column - 1
  end

  [line, column]
end

def time_diff(start_time, end_time)
  seconds_diff = (start_time - end_time).to_i.abs

  days = seconds_diff / 86400
  seconds_diff -= days * 86400

  hours = seconds_diff / 3600
  seconds_diff -= hours * 3600

  minutes = seconds_diff / 60
  seconds_diff -= minutes * 60

  seconds = seconds_diff

  [days, hours, minutes, seconds]
end

def calc_points(maze)
  TOTAL_PERCENTAGE - (maze.join.count(CHAR_STAR) * 10)
end

def game
  filename   = msg_select_maze
  maze       = read_maze(filename)
  start_time = Time.now

  while true
    msg_title_maze
    draw(maze)

    end_time = Time.now
    msg_user_status(maze, start_time, end_time)

    direction            = get_moves.downcase
    old_line, old_column = find_gamer(maze)

    if ['w', 'd', 's', 'a'].include?(direction)
      new_line, new_column = next_coordinates(direction, old_line, old_column)

      if is_moves_valid?(maze, new_line, new_column)
        maze[new_line][new_column] = maze[old_line][old_column]
        maze[old_line][old_column] = ' '
        msg_success_move

        if [27, 42] == [new_line, new_column]
          msg_congratulations(maze, start_time, end_time)
          sleep(1)
          break
        end
      else
        msg_invalid_move
      end
    elsif CMD_EXIT.include?(direction)
      msg_you_exit
      break
    else
      msg_invalid_char
    end
  end
end

def start_game
  clean
  msg_whats_your_name
  name = gets.chomp

  msg_welcome(name)
  msg_well_start_the_game

  msg_help

  return false if CMD_EXIT.include?(gets.chomp.downcase)

  game
end
