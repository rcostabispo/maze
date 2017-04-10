require 'io/console'

def msg_whats_your_name
  printf "What's your name? : "
end

def msg_select_maze
  printf "We've five mazes, enter a number from 1 to 5 to select : "
  id = gets.chomp
  "mazes/maze#{id}.txt"
end

def msg_well_start_the_game
  puts "We'll start the game for you :)"
end

def msg_welcome(name)
  clean
  puts "Welcome to Maze #{name}!!"
end

def msg_time_diff(arr)
  days, hours, minutes, seconds = arr
  "#{days} Days #{hours} Hrs #{minutes} Min #{seconds} Sec"
end

def msg_user_status(maze, start_time, end_time)
  puts "You've +#{calc_points(maze)} points and have been playing for #{msg_time_diff(time_diff(start_time, end_time))}."
end

def msg_invalid_char
  clean
  puts "Error: Invalid character\n"
end

def msg_invalid_move
  clean
  puts "Error: Invalid move\n"
end

def msg_success_move
  clean
  puts "Success: Continue\n"
end

def msg_you_exit
  puts "You exit of the game"
end

def msg_title_maze
  puts "############################################ \n" +
       "#      ___  ___       ___   ______  _____  # \n" +
       "#     /   |/   |     /   | |___  / | ____| # \n" +
       "#    / /|   /| |    / /| |    / /  | |__   # \n" +
       "#   / / |__/ | |   / / | |   / /   |  __|  # \n" +
       "#  / /       | |  / /  | |  / /__  | |___  # \n" +
       "# /_/        |_| /_/   |_| /_____| |_____| #"
end

def msg_help
  puts "\nAbout: \n" +
       "Maze 1.0.0 - (C) 2017 Ronaldo da Costa Bispo\n\n"+
       "- w  One step to top \n" +
       "- d  One step to right\n" +
       "- s  One step to bottom\n" +
       "- a  One step to left\n" +
       "- q  Exit\n\n" +
       "Press <Enter> to continue or <q> to exit\n"
end

def msg_congratulations(maze, start_time, end_time)
  points = calc_points(maze)
  time   = msg_time_diff(time_diff(start_time, end_time))
  clean
  puts "  _____                             _         _       _   _                           \n" +
       " /  __ \\                           | |       | |     | | (_)                         \n" +
       " | /  \\/ ___  _ __   __ _ _ __ __ _| |_ _   _| | __ _| |_ _  ___  _ __  ___          \n" +
       " | |    / _ \\| '_ \\ / _` | '__/ _` | __| | | | |/ _` | __| |/ _ \\| '_ \\/ __|      \n" +
       " | \\__/\\ (_) | | | | (_| | | | (_| | |_| |_| | | (_| | |_| | (_) | | | \\__ \\      \n" +
       "  \\____/\\___/|_| |_|\\__, |_|  \\__,_|\\__|\\__,_|_|\\__,_|\\__|_|\\___/|_| |_|___/ \n" +
       "                     __/ |                                                            \n" +
       "                    |___/ , you found the way out.               +#{points} points \n\n\n" +
       "Elapsed time: #{time}"
end

def draw(maze)
  puts maze
end

def clean
  puts `clear`
end

def get_moves
  puts "\nWhere do you want to go?"
  STDIN.getch
end
