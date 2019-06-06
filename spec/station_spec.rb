require 'station'
describe Station do

  let(:station) {Station.new("Ilford",4)}

  it 'knows its name' do
    expect(station.name).to eq("Ilford")
  end

  it 'knows its zone' do
    expect(station.zone).to eq(4)
  end
end
