require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    non_losing_moves = []

    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      non_losing_moves << child.prev_move_pos unless child.losing_node?(mark)
    end

    return non_losing_moves.sample unless non_losing_moves.empty?

    raise "This is impossible; I never lose!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
