describe "#rps_game_winner" do
  it "should be defined" do
    lambda { rps_game_winner() }.should_not raise_error(::NoMethodError)
  end

  # this is given for free in the outline
  it "should raise WrongNumberOfPlayersError if there are not exactly two players" do
    lambda { rps_game_winner([ ["Allen", "S"] ]) }.should raise_error(WrongNumberOfPlayersError), "No error raised for incorrect number of players"
  end
end

describe "#rps_tournament_winner" do
  it "should be defined" do
    lambda { rps_tournament_winner() }.should_not raise_error(::NoMethodError)
  end
end
