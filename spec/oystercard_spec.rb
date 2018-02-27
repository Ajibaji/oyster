require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new } #gives fresh instance of Oystercard

    context 'created without initial balance' do

      it 'default balance is 0' do
        expect(subject.balance).to eq(0)
      end
    end

    context 'created with set initial balance' do
      subject(:oystercard) { Oystercard.new(20) }
      it 'sets parameter to initial balance' do
        expect(subject.balance).to eq(20)
      end

    end

  describe '#transaction' do
  #subject(:oystercard) { Oystercard.new(20) }
    it 'adds to balance' do
      allow_any_instance_of(Oystercard).to receive(:transaction) do
        subject.transaction(30)
        expect(subject.balance).to eq(30)
      end
    end

    it 'subtract from balance #assuming adds to balance works' do
      allow_any_instance_of(Oystercard).to receive(:transaction) do
        subject.transaction(30)
        subject.transaction(-10)
        expect(subject.balance).to eq(20)
      end
    end

    it 'throws a wobbly if you try to exceed balance limit' do
      allow_any_instance_of(Oystercard).to receive(:transaction) do
        expect { subject.transaction(91) }.to raise_error "max balance is #{Oystercard::BALANCE_LIMIT}"
      end
    end

    it 'cannot make a transaction with insufficient funds' do
      allow_any_instance_of(Oystercard).to receive(:transaction) do
        expect { subject.transaction(-1) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
      end 
    end
  end

  describe '#touch_in' do
    subject(:oystercard) { Oystercard.new(1) }

    it 'should return true if oystercard is touched in' do
      expect(subject.touch_in).to eq(true)
    end

    it 'should raise an error if card has insufficient balance' do
      subject.balance = 0
      expect { subject.touch_in }.to raise_error "insufficient funds for this journey"
    end

  end

  describe '#touch_out' do
    subject(:oystercard) { Oystercard.new(1) }

    it 'should return false in ostercard is touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end

    it 'should deduct MIN_FARE from balance and return balance' do
      subject.touch_in
      expect { subject.touch_out }.to change{subject.balance}.by(-1)
    end
  end

  describe '#in_journey?' do
    subject(:oystercard) { Oystercard.new(1) }
    it 'should return the value of in_journey instance variable' do
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end
end
