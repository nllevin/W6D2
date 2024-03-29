require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.won? && board.winner != evaluator if board.over?
    if next_mover_mark == evaluator
      children.all? { |node| node.losing_node?(evaluator) }
    else
      children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over? 
    if next_mover_mark == evaluator
      children.any? { |node| node.winning_node?(evaluator) }
    else
      children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_nodes = []

    board.rows.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        pos = [i,j]
        if board.empty?(pos)
          duped_board = board.dup
          duped_board[pos] = next_mover_mark
          new_next_mover_mark = ((next_mover_mark == :x) ? :o : :x)

          child_nodes << TicTacToeNode.new(duped_board, new_next_mover_mark, pos)
        end
      end
    end

    child_nodes
  end
end
