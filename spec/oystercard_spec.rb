require_relative "../lib/oystercard.rb"

describe Oystercard do
  
  # tests if an oyster card responds to balance
  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  # Testing a top up function
  describe "#top_up" do
    it "should add money to the balance of the card" do
     expect { subject.top_up(50) }.to change { subject.balance }.by(50)
    end

    it "should stop top_up if we add something that breaks the limit" do
      expect { subject.top_up(100) }.to raise_error("this has exceeded the top up limit value of 90")
    end
  end



  #Testing the touchin method
  describe "#touchin" do
      #Testing if the function exists
      it {is_expected.to respond_to(:touchin).with(1).argument}
      
      #Testing if we create a oystercard then we touch in and it says that the card is on a journey
      it "should update in_journey to true after touching in" do
        subject.top_up(1)
        subject.touchin(station)
        expect(subject.in_journey?).to eq true
      end
      
      # it "should stop top_up if we add something that breaks the limit" do
      it "should not touch in if the balance is below the min balance" do
        min = Oystercard::MIN_BALANCE
        expect {subject.touchin(station)}.to raise_error("can not touch in balance below #{min}")
      end
      
      #it should make the card remember the entry station
      let(:station) {double :station}
      it "it should make the card remember the entry station" do
        subject.top_up(5)
        subject.touchin(station)
        expect(subject.start_station).to eq station
      end 



  end

  #Testing the touchout method
  describe "#touchout" do
      it {is_expected.to respond_to(:touchout).with(0).argument}

      #Testing if we create a oystercard then we touch out and it says that the card is on a journey
      it "should update in_journey to true after touching out" do
        subject.top_up(1)
        subject.touchin(station)
        subject.touchout
        expect(subject.in_journey?).to eq false
      end
      #Testing if fare is deducted
      let(:station) {double :station}
      it "should have an oyster card that touches out and reduces the balance by the min balance which is assumed to be the fare" do
        subject.top_up(78)
        subject.touchin(station)
        expect {subject.touchout}.to change {subject.balance}.by(-1)
      end

      # #Testing if the start station is nul once card is touched out
      # let(:station) {double :station}
      # it "should show nil in response to stat_station once card is touched out" do
      #   subject.top_up(5)
      #   subject.touchin(station)
      #   subject.touchout
      #   expect {subject.start_station}.to eq nil
      # end

  end

  #Testing the in_journey? method
  describe "#in_journey?" do
    it "should return false" do
      expect(subject.in_journey?).to eq false
    end
  end

end