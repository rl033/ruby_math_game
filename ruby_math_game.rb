require 'colorize'

def initialize_game
  @player1_life = 3
  @player2_life = 3
  @turn = 1
  @round = 1
end

def gen_questions(player)
  @num1 = rand(20) + 1
  @num2 = rand(20) + 1
  return "Player #{player}: What does #{@num1} plus #{@num2} equal?"
end

def verify_answer(answer)
  result = @num1 + @num2
  return answer.to_i == result ? true : false
end

def prompt_player_for_answer(player)
  puts "Player #{player}: What's you answer?"
  gets.chomp
end

def game_end?
  return @player1_life == 0 || @player2_life == 0 ? true : false
end

def update_status(player)
  case player
  when 1
    @player1_life -= 1
  when 2
    @player2_life -= 1
  end
end

def display_result(result) 
  puts result ? "You got this question right!".green : "You answer is wrong.".red
end

def display_status
  puts "Player 1 has #{@player1_life} live(s) left."
  puts "Player 2 has #{@player2_life} live(s) left."
  if game_end?
    puts "The game is over!"
    puts "Player 1 won!" if @player2_life == 0
    puts "Player 2 won!" if @player1_life == 0
  end
  puts ""
end

initialize_game
while(!game_end?)
  puts "Ruby Math Game"

  puts gen_questions(1)
  answer = prompt_player_for_answer(1)
  result = verify_answer(answer) 
  display_result(result)
  unless result
    update_status(1)
    display_status
  end

  break if game_end?
  puts "Player 2, your turn"
  puts gen_questions(2)
  answer = prompt_player_for_answer(2)
  result = verify_answer(answer) 
  display_result(result)
  unless result
    update_status(2)
    display_status
  end

  display_status
end
