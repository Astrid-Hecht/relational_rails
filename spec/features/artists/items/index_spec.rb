# As a visitor
# When I visit '/parents/:parent_id/child_table_name'
# Then I see each Child that is associated with that Parent with each Child's attributes:

require 'rails_helper'

RSpec.describe 'Artists items index' do
  before :each do
    @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                               accepts_returns: false)
    @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                               accepts_returns: true)
    @item_1 = @artist_1.items.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                                      stock: 100, num_sold: 3, free_shipping: true)
    @item_2 = @artist_2.items.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                                      stock: 5, num_sold: 59, free_shipping: false)

    visit "/artists/#{@artist_2.id}/items"
  end

  it 'Then I see each item that is associated with that artist with each items attributes' do
    expect(page).to have_content(@artist_2.username)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_2.rating)
    expect(page).to have_content(@item_2.price)
    expect(page).to have_content(@item_2.stock)
    expect(page).to have_content(@item_2.num_sold)
    expect(page).to have_content('Paid')
  end

  it 'and nothing from a different artist' do
    expect(page).to_not have_content(@artist_1.username)
    expect(page).to_not have_content(@item_1.name)
    expect(page).to_not have_content("Number Sold: #{@item_1.num_sold}")
  end

  it 'items are clickable' do
    click_link("#{@item_2.name}")
    expect(current_path).to eq("/items/#{@item_2.id}")
  end

  it 'every item has an update button that takes you to edit page when clicked' do
    @item_3 = @artist_2.items.create!(name: 'Borzoi Baseball', rating: 4.7, price: 25.01,
      stock: 10, num_sold: 9, free_shipping: true)

    visit "/artists/#{@artist_2.id}/items"

    expect(page.all('.item')[0]).to have_button('Edit Item')
    expect(page.all('.item')[1]).to have_button('Edit Item')
    within(page.all('.item')[0]) do
      click_link('Edit Item')
    end
    expect(current_path).to eq("/items/#{@item_2.id}/edit")
  end

  it 'items can be sorted alphabtically' do
    @item_3 = @artist_2.items.create!(name: 'zoBorzoi Baseball', rating: 4.7, price: 25.01,
      stock: 10, num_sold: 9, free_shipping: true)
      
    visit "/artists/#{@artist_2.id}/items" 

    click_button('Sort Alphabetically')
    expect(page.all('.item')[0]).to have_content(@item_2.name)
    expect(page.all('.item')[1]).to have_content(@item_3.name)
  end
end
