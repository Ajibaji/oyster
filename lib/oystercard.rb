class Oystercard
attr_accessor :balance
attr_reader :in_journey
attr_reader :entry_station
attr_accessor :journeys_log
attr_accessor :last_journey

BALANCE_LIMIT = 90
MIN_FARE = 1

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @journeys_log = []
    @last_journey = {}
  end

  def touch_in(entry_station)
    if @balance < MIN_FARE
      raise "insufficient funds for this journey"
    else
      @entry_station = entry_station
      @in_journey = true
    end
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    journey_completed
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def transaction(amount)
    raise "max balance is #{BALANCE_LIMIT}" if (@balance + amount) > BALANCE_LIMIT
    raise "insufficient funds: current balance is #{@balance}" if (@balance + amount) < 0
    @balance += amount
  end

  def journey_completed
    @last_journey = { :entry => @entry_station, :exit => @exit_station }
    transaction(-MIN_FARE)
    @in_journey = false
    add_to_log
  end

  def add_to_log
    @journeys_log << @last_journey
    @last_journey = nil
  end

end
