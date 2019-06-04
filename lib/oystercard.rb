class Oystercard
  attr_reader :balance, :BAL_LIMIT, :in_use, :MIN_BAL
  BAL_LIMIT = 90
  MIN_BAL = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Maximum balance of #{BAL_LIMIT}" if @balance + amount > BAL_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

end
