class Oystercard
attr_reader :balance
BALANCE_LIMIT = 90

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @in_journey = false
  end

  def transaction(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    raise "insufficient funds: current balance is #{@balance}" if (@balance + amount) < 0
    @balance += amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end 

  def in_journey?
    @in_journey
  end
end
