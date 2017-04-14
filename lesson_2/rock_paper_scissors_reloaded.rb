VALID_CHOICES =  %w(rock paper scissors lizard spock)
def intro
  prompt('You look like a worthy foe!')
  prompt('First to five, OK?')
  prompt('Looks like you can\'t say no...')
  prompt('-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-')
end

WINNING_CONDITIONS = { 'rock' => ['scissors', 'lizard'],
                       'paper' => ['rock', 'spock'],
                       'scissors' => ['paper', 'lizard'],
                       'lizard' => ['paper', 'spock'],
                       'spock' => ['scissors', 'rock'] }

def choices_to_text(player1, player2)
  prompt("You chose #{full_words(player1)}; the computer chose #{player2}")
end

def full_words(player1_choice)
  case choice
  when 'r'
    'rock'
  when 's'
    'scissors'
  when 'p'
    'paper'
  when 'o'
    'lizard'
  when 'c'
    'spock'
  end
end

def win?(player1, player2)
  WINNING_CONDITIONS.fetch(player1).include?(player2)
end

def display_results(player, computer)
  if win?(full_words(player), computer)
    prompt('You won!')
  elsif win?(computer, full_words(player))
    prompt('You lost!')
  else
    prompt('You tied!')
  end
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def lineup
  puts <<-LINEUP
              Please choose one of the following:
        
       r(rock), p(paper), s(scissors), o(lizard), c(spock)
       LINEUP
end

options = "rpsoc"

intro

choice = ''
loop do
  player_score = 0
  computer_score = 0
  loop do
    loop do
      lineup
      choice = Kernel.gets().chomp()
      break if options.include?(choice)
      prompt("No can do!")
      prompt("You must chose one of the agreed-upon options.")
      prompt('-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-')
    end

    computer_choice = VALID_CHOICES.sample

    choices_to_text(choice, computer_choice)

    display_results(choice, computer_choice)
    if win?(full_words(choice), computer_choice)
      player_score += 1
    elsif win?(computer_choice, full_words(choice))
      computer_score += 1
    else
      prompt('Zero for both teams!')
    end
    prompt("Current score is:")
    prompt("You: #{player_score}")
    prompt("Computer: #{computer_score}")

    if player_score >= 5
      prompt("You win it all!")
      break
    elsif computer_score >= 5
      prompt("You lose it all!")
      break
    else
      prompt("Here we go again!")
    end
  end
  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end
prompt('Good game!')
