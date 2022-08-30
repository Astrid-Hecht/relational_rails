require 'rails_helper'

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end

RSpec.describe Item, type: :model do
  it {should belong_to :artist}
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

  it 'index only selects items with true boolean' do
    items = Item.true_select
    expect(items).to eq(Item.where(free_shipping: true))
  end

  it 'can order alphabetically' do
    items = Item.all
    expect(items.ordered).to eq([@item_2, @item_1])
  end

end