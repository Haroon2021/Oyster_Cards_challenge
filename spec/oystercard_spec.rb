require_relative "../lib/oystercard.rb"

describe Oystercard do
  #Having a double here allows us to use it within this describe block (in this case we can use it in the whole code as this des block is for the whole code)
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  # tests if an oyster card responds to balance
  
  describe '#list_of_journeys' do 
    it 'has an empty array of journeys by default' do
      expect(subject.list_of_journeys).to eq []
    end
  end
  
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
    # before do
    #   subject.top_up(5)
    # end
      #Testing if the function exists
      it {is_expected.to respond_to(:touchin).with(1).argument}
      #let(:station) {double :station}
      #Testing if we create a oystercard then we touch in and it says that the card is on a journey
      it "should update in_journey to true after touching in" do
        subject.top_up(1)
        subject.touchin(entry_station)
        allow(entry_station).to receive(:start_station).and_return(true)
        #expect(subject.start_station).to eq true
      end
      
      # it "should stop top_up if we add something that breaks the limit" do
      it "should not touch in if the balance is below the min balance" do
        min = Oystercard::MIN_BALANCE
        expect {subject.touchin(entry_station)}.to raise_error("can not touch in balance below #{min}")
      end
      
      #it should make the card remember the entry station
      
      it "it should make the card remember the entry station" do
        subject.top_up(5)
        subject.touchin(entry_station)
        expect(subject.entry_station).to eq entry_station
      end 



  end

  #Testing the touchout method
  describe "#touchout" do

      let(:journey) { {start: entry_station, end: exit_station} }
      it {is_expected.to respond_to(:touchout).with(1).argument}

      #Testing if we create a oystercard then we touch out and it says that the card is on a journey
      it "should update in_journey to true after touching out" do
        subject.top_up(1)
        subject.touchin(entry_station)
        subject.touchout(exit_station)
        expect(subject.in_journey?).to eq false
      end

      it "should save the journey" do
        subject.top_up(5)
        subject.touchin(entry_station)
        subject.touchout(exit_station)
        expect(subject.list_of_journeys).to include journey
      end

      #Testing if fare is deducted

      it "should have an oyster card that touches out and reduces the balance by the min balance which is assumed to be the fare" do
        subject.top_up(78)
        subject.touchin(entry_station)
        expect {subject.touchout(exit_station)}.to change {subject.balance}.by(-1)
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
    subject.touchout(exit_station)
      expect(subject.entry_station).to eq nil 
    end
  end

end