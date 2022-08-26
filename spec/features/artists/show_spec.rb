require 'rails_helper'

# As a visitor
# When I visit '/parents/:id'
# Then I see the parent with that id including the parent's attributes:
# - data from each column that is on the parent table

RSpec.describe 'Artists#show' do
  describe 'as a visitor' do
    describe 'when I visit "/artist/:id"' do
      before :each do
        @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                   accepts_returns: false)
        @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                   accepts_returns: true)

        visit "/artists/#{@artist_1.id}"
      end

      it 'Then I see the artist with that id' do
        expect(page).to have_content(@artist_1.username)
        expect(page).to_not have_content(@artist_2.username)
      end

      it "including the artists's attributes" do
        expect(page).to have_content(@artist_1.location)
        expect(page).to have_content(@artist_1.followers)
        expect(page).to have_content(@artist_1.accepts_returns)
      end

      it 'I see a count of the number of children associated with this parent' do
        @item_1 = @artist_1.items.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2,
                                          price: 44.95, stock: 100, num_sold: 3, free_shipping: true)
        @item_2 = @artist_2.items.create!(name: 'Boxer Bowler', rating: 5.0,
                                          price: 35.01, stock: 5, num_sold: 59, free_shipping: false)
        visit "/artists/#{@artist_1.id}"
        within '#shop_breakdown' do
          expect(page.all('.item_count')[0]).to have_content(@artist_1.items.count)
        end
      end

      it "Then I see a link to take me to that artists's `items` page ('/artists/:id/items')" do
        @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                   accepts_returns: false)
        @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                   accepts_returns: true)
        @item_1 = Item.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                               stock: 100, num_sold: 3, free_shipping: true, artist_id: @artist_1.id)
        @item_2 = Item.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                               stock: 5, num_sold: 59, free_shipping: false, artist_id: @artist_2.id)
        visit "/artists/#{@artist_1.id}"

        expect(page).to have_content("Artist's shop")
        click_link("Artist's shop")
        expect(current_path).to eq("/artists/#{@artist_1.id}/items")
      end
    end
  end
end
