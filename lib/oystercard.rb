#require 'journey'

class Oystercard
attr_accessor :balance
attr_accessor :journeys_log
attr_accessor :card

$BALANCE_LIMIT = 90
$MIN_FARE = 1
$PENALTY_FARE = 6

  def initialize(initial_balance = 0)
    @balance = initial_balance
    @journeys_log = []
    @card = self
  end

  def new_journey(entry_station)
    Journey.new(self, entry_station)
  end

  def transaction(amount)
    raise "max balance is #{$BALANCE_LIMIT}" if (@balance + amount) > $BALANCE_LIMIT
    raise "insufficient funds: current balance is #{@balance}" if (@balance + amount) < 0
    @balance += amount
  end

  def add_to_log(last_journey)
    @journeys_log << last_journey
  end

end
