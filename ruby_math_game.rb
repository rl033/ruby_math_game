require 'colorize'

def initialize_game
  @player1_name = ""
  @player2_name = ""
  @player1_life = 3
  @player2_life = 3
  @type = 1
  @turn = 1
  @count = 0
  @round = 1
  @end = false
  @restart = false
end

def gen_questions
  @num1 = rand(20) + 1
  @num2 = rand(20) + 1
  @type = rand(3) + 1
  name = @turn == 1 ? @player1_name : @player2_name
  
  case @type
  when 1
    op = "plus"
  when 2
    op = "minus"
  when 3
    op = "times"
  else
    op = ""
  end
  return "#{name}, what does #{@num1} #{op} #{@num2} equal?"
end

def verify_answer(answer)
  case @type
  when 1
    result = @num1 + @num2
  when 2
    result = @num1 - @num2
  when 3
    result = @num1 * @num2
  else
    result = 0
  end
  return answer.to_i == result ? true : false
end

def prompt_player_for_name
  puts "Player #{@turn}, what's your name?"
  @player1_name = gets.chomp if @turn == 1
  @player2_name = gets.chomp if @turn == 2
end

def prompt_player_for_answer
  puts @turn == 1 ? "#{@player1_name}, what's you answer?" : "#{@player2_name}, what's you answer?"
  gets.chomp
end

def prompt_player_for_restart
  puts "\nWant to play again?"
  gets.chomp.downcase
end

def game_end?
  @end = @player1_life == 0 || @player2_life == 0 ? true : false
end

def game_restart?(player_response)
  if player_response.include? "yes"
    @end = false
    @restart = true
  end
end

def update_status(result)
  unless result
    case @turn
    when 1
      @player1_life -= 1
    when 2
      @player2_life -= 1
    end
  end
  @count += 1
end

def turn_manager
  @turn = @turn == 1 ? 2 : 1
  if @count == 2
    @round += 1
    @count = 0
  end
end

def display_result(result) 
  puts result ? "You got this question right!\n".green : "Sorry, your answer is wrong.\n".red
end

def display_status
  puts "#{@player1_name} has #{@player1_life} live(s) left."
  puts "#{@player2_name} has #{@player2_life} live(s) left." unless @round == 1 && @turn == 1
  if game_end?
    puts "\nThe game is over!"
    puts "#{@player1_name} won!" if @player2_life == 0
    puts "#{@player2_name} won!" if @player1_life == 0
  end
  puts ""
end

initialize_game
puts "Ruby Math Game"
while(!@end)
  initialize_game if @restart
  puts "Round #{@round}".blue if @count == 0
  prompt_player_for_name if @round == 1
  puts gen_questions
  answer = prompt_player_for_answer
  result = verify_answer(answer) 
  display_result(result)
  update_status(result)
  display_status if @count == 2 || result == false
  turn_manager
  game_restart?(prompt_player_for_restart) if game_end?
end