require_relative '../lib/oystercard'

class Journey
  attr_reader :in_journey
  attr_accessor :entry_station
  attr_accessor :journey
  attr_reader :this_journey
  attr_accessor :exit_station

  def initialize(oystercard)
    @card = oystercard
    @balance = @card.balance
    @exit_station = nil
    @this_journey = {}
    @entry_station = nil
    @in_journey = true
  end

  def touch_in(entry_station)
    raise "insufficient funds for this journey" if @card.balance < $MIN_FARE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    journey_completed
  end

  def journey_completed
    @this_journey = { :entry => @entry_station, :exit => @exit_station }
    @card.transaction(-fare)
    @in_journey = false
    @card.add_to_log(@this_journey)
  end

  def fare
    if (@entry_station.nil? && !@exit_station.nil?) || (!@entry_station.nil? && @exit_station.nil?)
      ($PENALTY_FARE)
    else
      ($MIN_FARE)
    # if !@entry_station.nil? && !@exit_station.nil?
    #   $MIN_FARE
    # else
    #   $PENALTY_FARE
    end
    #(@entry_station = nil && @exit_station = nil) if @in_journey = false
  end

  def in_journey?
    !!@entry_station
  end

end
