require 'oystercard'

class Journey
  attr_reader :in_journey
  attr_reader :entry_station
  attr_accessor :journey
  attr_reader :this_journey

  def initialize(oystercard, entry_station)
    @card = oystercard
    raise "insufficient funds for this journey" if @card.balance < $MIN_FARE
    @balance = @card.balance
    @exit_station = nil
    @this_journey = {}
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    journey_completed
    @entry_station = nil
    @exit_station = nil
  end

  def journey_completed
    @this_journey = { :entry => @entry_station, :exit => @exit_station }
    @card.transaction(-$MIN_FARE)
    @in_journey = false
    @card.add_to_log(@this_journey)
    @entry_station = nil
  end

  def fare
    !@entry_station.nil? && !@exit_station.nil? ? $MIN_FARE : $PENALTY_FARE
  end

  def in_journey?
    !!@entry_station
  end

end
