

class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    p "#{name} What letter would you like to add? "
    gets[0]
  end

  def alert_invalid_guess
    p "whoops not a valid guess"
  end
end
