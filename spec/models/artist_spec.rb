require 'rails_helper'

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

RSpec.describe Artist, type: :model do
  it {should have_many :items}
  before :each do
    @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
      accepts_returns: false)
    @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
      accepts_returns: true)
    @item_1 = @artist_1.items.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
      stock: 100, num_sold: 3, free_shipping: true)
    @item_2 = @artist_2.items.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
      stock: 5, num_sold: 59, free_shipping: false)
  end

  it 'sorts artist index by most recenetly created' do
    @artists = Artist.recent
    expect(@artists).to eq([@artist_2, @artist_1])
  end

  it 'can count items by artist' do
    expect(@artist_1.tot_stock).to eq(1)
  end
end
