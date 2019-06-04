require 'oystercard'

describe Oystercard do
  subject { Oystercard.new }

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

  describe '#deduct' do
    it 'takes an argument and deducts it from the balance' do
      subject.top_up(45)
#     subject.deduct(5)
#     expect(subject.balance).to eq(40)
      expect(subject.deduct(5)).to eq(40)
    end
  end

    it 'responds to if the customer is in journey' do
      expect(subject.in_journey?).to be_falsey
    end

    it 'allows customer to touch in' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it 'allows customer to touch out' do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
    it 'raises error when balance in insufficient' do
      expect { subject.touch_in }.to raise_error("Oystercard balance insufficient")
    end
end
