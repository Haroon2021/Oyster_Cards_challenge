require_relative '../lib/station'

describe Station do
it 'returns the zone' do
    station = Station.new("Station1",1)
    expect(station.zone).to eq 1
end

it 'returns the station name' do
    station = Station.new("Station1",1)
    expect(station.name).to eq "Station1"

end
end