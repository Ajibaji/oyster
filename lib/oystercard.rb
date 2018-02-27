class Oystercard
attr_accessor :balance
attr_reader :in_journey
BALANCE_LIMIT = 90
MIN_FARE = 1

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @in_journey = false
  end

  def touch_in
    if @balance < MIN_FARE
      raise "insufficient funds for this journey"
    else
      @in_journey = true
    end
  end

  def touch_out
    @in_journey = false
    transaction(-MIN_FARE)
  end

  def in_journey?
    @in_journey
  end

  private
  def transaction(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    raise "insufficient funds: current balance is #{@balance}" if (@balance + amount) < 0
    @balance += amount
  end

end
