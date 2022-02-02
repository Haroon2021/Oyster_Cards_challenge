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
      it {is_expected.to respond_to(:touchin).with(0).argument}
      
      #Testing if we create a oystercard then we touch in and it says that the card is on a journey
      it "should update in_journey to true after touching in" do
        subject.top_up(1)
        subject.touchin
        expect(subject.in_journey?).to eq true
      end
      
      # it "should stop top_up if we add something that breaks the limit" do
      it "should not touch in if the balance is below the min balance" do
        expect {subject.touchin}.to raise_error("can not touch in balance below min balance")
      end

  end

  #Testing the touchout method
  describe "#touchout" do
      it {is_expected.to respond_to(:touchout).with(0).argument}

      #Testing if we create a oystercard then we touch out and it says that the card is on a journey
      it "should update in_journey to true after touching out" do
        subject.top_up(1)
        subject.touchin
        subject.touchout
        expect(subject.in_journey?).to eq false
      end
      #Testing if fare is deducted
      it "should have an oyster card that touches out and reduces the balance by the min balance which is assumed to be the fare" do
        subject.top_up(78)
        subject.touchin
        expect {subject.touchout}.to change {subject.balance}.by(-1)
        # expect {}.to change{}.by()
        # expect { subject.deduct(20) }.to change { subject.balance }.by(-20)
      end
  end

  
  #Testing the in_journey? method
  describe "#in_journey?" do
    it "should return false" do
      expect(subject.in_journey?).to eq false
    end
  end

end