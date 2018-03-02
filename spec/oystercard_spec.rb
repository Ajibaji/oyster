require 'oystercard'
require 'journey'

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
      #allow_any_instance_of(Oystercard).to receive(:transaction) do
        subject.transaction(30)
        expect(subject.balance).to eq(30)
      #end
    end

    it 'subtract from balance #assuming adds to balance works' do
      #allow_any_instance_of(Oystercard).to receive(:transaction) do
        subject.transaction(30)
        subject.transaction(-10)
        expect(subject.balance).to eq(20)
      #end
    end

    it 'throws a wobbly if you try to exceed balance limit' do
      #allow_any_instance_of(Oystercard).to receive(:transaction) do
        expect { subject.transaction(91) }.to raise_error "max balance is #{$BALANCE_LIMIT}"
      #end
    end

    it 'cannot make a transaction with insufficient funds' do
      #allow_any_instance_of(Oystercard).to receive(:transaction) do
        subject.balance = 0
        expect { subject.transaction(-1) }.to raise_error "insufficient funds: current balance is #{subject.balance}"
      #end
    end
  end

  describe '#journeys' do
    subject(:oystercard) { Oystercard.new(1) }

    it 'should check that an empty array of journeys has been created' do
      expect(subject.journeys_log).to be_empty
    end

  end

end
