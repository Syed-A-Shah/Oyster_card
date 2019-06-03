require 'oystercard'

describe Oystercard do
  it 'shows balance' do
    expect(subject.balance).to eq(0)
  end

  it '#top up' do
    card = Oystercard.new
    expect{ card.top_up 1 }.to change{ card.balance }.by 1
  end
end
