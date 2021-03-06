require_relative '../lib/journey.rb'

describe Journey do
  subject { described_class.new(station) }
  let(:station) { double :station, zone: 1 }

  it 'knows if a journ is not complete' do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting a journey' do
    expect(subject.finish(station)).to eq(subject)
  end

  context 'given a entry station' do
    
    it 'has an entry station' do
      expect(subject.entry_station).to eq station 
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  context 'given an exit station' do
    let(:other_station) { double :other_station }
  
    before do 
      subject.finish(other_station)
    end
  
    it 'calculates a fare' do
      expect(subject.fare).to eq 1
    end
  end
end