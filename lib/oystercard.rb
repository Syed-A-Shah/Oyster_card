class Oystercard
  attr_reader :balance, :in_use, :BAL_LIMIT, :MIN_BAL, :entry_station, :exit_station
  BAL_LIMIT = 90
  MIN_BAL = 1
  MIN_CHARGE = 5

  def initialize
    @balance = 0
    @in_use = false
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{BAL_LIMIT}" if @balance + amount > BAL_LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station != nil ? @in_journey = true : @in_journey = false
  end

  def touch_in(station)
    fail "Oystercard balance insufficient" if @balance < MIN_BAL
    @in_use = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @in_use = false
    @exit_station = station
  end

  def entry_station
    @entry_station
  end

  def exit_station
    @exit_station
  end

  def journey_history
    journey = {@entry_station => @exit_station}
    @journeys << journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
