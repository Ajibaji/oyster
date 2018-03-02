require 'journey'
require 'oystercard'

describe Journey do
  subject(:card) { Oystercard.new(10) }
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  subject(:journey) { card.new_journey(entry_station) }


  describe '#initialize' do
    # some code
  end

  describe '#touch_in' do

    it 'should raise an error if card has insufficient balance' do
      card.balance = 0
      expect { journey.touch_in(entry_station) }.to raise_error "insufficient funds for this journey"
    end

    it 'should remember the entry station after touch_in' do
      expect(journey.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    before(:each) do
        journey.touch_in(entry_station)
    end

    it 'should return false if oystercard is touched out' do
      journey.touch_out(exit_station)
      expect(journey.in_journey).to eq(false)
    end

    it 'should deduct fare from balance and return balance' do
      journey.touch_out(exit_station)
      expect { journey.touch_out(exit_station) }.to change{card.balance}.by(-journey.fare)
    end

    # it 'should set @in_journey to nil once touched out' do
    #   journey.touch_out(exit_station)
    #   expect(journey.entry_station).to be_nil
    # end

    it 'should store journey in a hash on touch_out' do
      journey.touch_out(exit_station)
      expect(journey.this_journey.nil?).to eq(false)
    end

  end

  describe '#fare' do
    it 'should return MIN_FARE if entry and exit_station != nil' do
      journey.touch_in(entry_station)
      journey.touch_out(exit_station)
      expect(journey.fare).to eq($MIN_FARE)
    end
    it 'should return PENALTY_FARE' do
      journey.touch_in(entry_station)
      expect(journey.fare).to eq($PENALTY_FARE)
    end
    it 'should return PENALTY_FARE' do
      # journey.entry_station != nil
      journey.touch_out(exit_station)
      expect(journey.fare).to eq($PENALTY_FARE)
    end
  end

  describe '#in_journey?' do
    let(:station){ double :station }
    it 'should return the value of in_journey instance variable' do
      expect(subject.in_journey?).to eq(true)
    end
  end

end
