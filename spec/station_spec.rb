require 'Station'

describe Station do
  subject(:station) { Station.new("Clapham South", 2) }

  describe '#initialize' do
    it 'should return name of station' do
      expect(subject.name).to eq("Clapham South")
      expect(subject.zone).to eq(2)
    end
  end
end
