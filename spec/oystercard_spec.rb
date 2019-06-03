require 'oystercard'

describe Oystercard do
  subject { Oystercard.new }
  it 'shows balance' do
    expect(subject.balance).to eq(0)
  end

  it '#top up' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'raises error when maximum balanced reached' do
    maximum = Oystercard::MAXIMUM_BALANCE
    subject.top_up maximum
   expect { subject.top_up 1 }.to raise_error("Maximum balance of #{maximum}")
  end

  it 'deducts money from my card' do
    subject.top_up(80)
    subject.deduct(20)
    expect(subject.balance).to eq(60)
  end
end
