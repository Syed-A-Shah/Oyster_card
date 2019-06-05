require 'oystercard'

describe Oystercard do
  subject { Oystercard.new }
  let(:station){ double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journeys) { {entry_station: entry_station, exit_station: exit_station} }
  it 'shows balance' do
    expect(subject.balance).to eq(0)
  end

  it '#top_up' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'raises error when maximum balanced reached' do
    maximum = Oystercard::BAL_LIMIT
    subject.top_up maximum
   expect { subject.top_up 1 }.to raise_error("Maximum balance of #{maximum}")
  end

#   describe '#deduct' do
#     it 'takes an argument and deducts it from the balance' do
#       subject.top_up(45)
# #     subject.deduct(5)
# #     expect(subject.balance).to eq(40)
#       expect(subject.deduct(5)).to eq(40)
  #   end
  # end

    it 'responds to if the customer is in journey' do
      expect(subject.in_journey?).to be_falsey
    end

    it 'allows customer to touch in' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it 'allows customer to touch out' do
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end

    it 'raises error when balance in insufficient' do
      expect { subject.touch_in(station) }.to raise_error("Oystercard balance insufficient")
    end

    it 'charges the customer at touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MIN_CHARGE)
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journey_history).to be_empty
    end
    
    it 'stores the entry station' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'stores exit station' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it 'stores one complete journey' do
      subject.top_up(5)
      subject.touch_in("Ilford")
      subject.touch_out("Mile End")
      expect(subject.journey_history).to eq ["Ilford" => "Mile End"]
    end
end
