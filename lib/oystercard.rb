class Oystercard
  attr_reader :balance, :BAL_LIMIT
  BAL_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{BAL_LIMIT}" if @balance + amount > BAL_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
