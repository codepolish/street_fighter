require 'spec_helper'

describe "tournamenting a game of street fighter" do

  Player = Struct.new(:name, :hero)

  # Perform a random battle, giving the hero 3 chances to win to every
  # 1 chance for the opponent. We must return the winner wrapped in a `Left`
  # if the winner is the opponent, or a `Right` if the winner is our hero.
  def battle(opponent, hero)
    winner = ([hero] * 3 << opponent).sample
    winner.hero ? StreetFighter::Right.new(winner) :
                  StreetFighter::Left.new(winner)
  end


  it "always returns a Left or a Right value" do
    ryu   = Player.new(:ryu, true)    # The hero!

    # The bad guys.
    retsu = Player.new(:retsu, false)
    geki  = Player.new(:geki,  false)
    joe   = Player.new(:joe,   false)

    fight = method(:battle).to_proc.curry

    winner = StreetFighter.tournament(ryu, fight[retsu], fight[geki], fight[joe])

    # case winner
    # when StreetFighter::Left
    #   puts "Our hero has been defeated, and #{winner.value.name} is the new champion."
    # when StreetFighter::Right
    #   puts "Ryu has defeated his opponents!"
    # end

    winner.must_be_kind_of StreetFighter::EitherValue
  end
end
