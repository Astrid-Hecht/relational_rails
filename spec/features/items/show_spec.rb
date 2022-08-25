require 'rails_helper'

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes:

RSpec.describe 'items#show' do
  describe 'as a visitor' do
    describe 'When I visit "/items/:id"' do
      before :each do
        @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                   accepts_returns: false)
        @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                   accepts_returns: true)

        @item_1 = Item.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                               stock: 100, num_sold: 3, free_shipping: true, artist_id: @artist_1.id)
        @item_2 = Item.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                               stock: 5, num_sold: 59, free_shipping: false, artist_id: @artist_2.id)
        visit "/items/#{@item_1.id}"
      end

      it 'Then I see the item with that id' do
        expect(page).to have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
      end

      it "including the items's attributes" do
        expect(page).to have_content(@item_1.rating)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.stock)
        expect(page).to have_content(@item_1.num_sold)
        if @item_1.free_shipping
          expect(page).to have_content('Free!')
        else
          expect(page).to have_content('Paid')
        end
      end
    end
  end
end
