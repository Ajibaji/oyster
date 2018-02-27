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

    it 'adds to balance' do
      subject.transaction(30)
      expect(subject.balance).to eq(30)
    end

    it 'subtract from balance #assuming adds to balance works' do
      subject.transaction(30)
      subject.transaction(-10)
      expect(subject.balance).to eq(20)
    end

    it 'throws a wobbly if you try to exceed balance limit' do
      expect { subject.transaction(91) }.to raise_error "max balance is #{Oystercard::BALANCE_LIMIT}"
    end

    it 'cannot make a transaction with insufficient funds' do
      expect { subject.transaction(-1) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
    end

  end

  describe '#touch_in' do
    subject(:oystercard) { Oystercard.new(1) }

    it 'should return true if oystercard is touched in' do
      expect(subject.touch_in).to eq(true)
    end

  end

  describe '#touch_out' do
    subject(:oystercard) { Oystercard.new(1) }

    it 'should return false if oystercard is touched out' do
      expect(subject.touch_out).to eq(false)
    end
    
  end

end
