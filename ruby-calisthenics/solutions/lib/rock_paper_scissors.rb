class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    case player1[1] + player2[1]
    when 'PR', 'SP', 'RS' then player1
    when 'RP', 'PS', 'SR' then player2
      # if both use same strategy, first player wins:
    when 'RR', 'PP', 'SS' then player1
    else raise NoSuchStrategyError, "Strategy must be one of R,P,S"
    end
  end

  def self.tournament_winner(tournament)
    # base case: we're looking at 2 arrays each containing 2 strings
    if tournament[0][0].kind_of?(String)
      winner(tournament[0], tournament[1])
    else
      winner(tournament_winner(tournament[0]), tournament_winner(tournament[1]))
    end
  end

end

