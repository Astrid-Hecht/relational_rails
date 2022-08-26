require 'rails_helper'

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

RSpec.describe 'Header', type: :feature do
  describe 'as a visitor' do
    describe 'When I visit any page on the site' do
      before :each do
        @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                   accepts_returns: false)
        @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                   accepts_returns: true)

        @item_1 = Item.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                               stock: 100, num_sold: 3, free_shipping: true, artist_id: @artist_1.id)
        @item_2 = Item.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                               stock: 5, num_sold: 59, free_shipping: false, artist_id: @artist_2.id)
      end

      describe 'Then I see a link at the top of the page that takes me to the Child Index' do
        it 'works on /items pages' do
          visit '/items'
          within('#navigation') do
            expect(page).to_have content('Items')
            click_link('items')
            expect(current_path).to eq('/items')
          end

          visit "/items/#{@item_1.id}"
          within('#navigation') do
            expect(page).to_have content('Items')
            click_link('items')
            expect(current_path).to eq('/items')
          end
        end

        it 'works on /artists pages' do
          visit '/artists'
          within('#navigation') do
            expect(page).to_have content('Items')
            click_link('items')
            expect(current_path).to eq('/items')
          end

          visit "/artists/#{@artist_1.id}"
          within('#navigation') do
            expect(page).to_have content('Items')
            click_link('items')
            expect(current_path).to eq('/items')
          end

          visit "/artists/#{@artist_1.id}/items"
          within('#navigation') do
            expect(page).to_have content('Items')
            click_link('items')
            expect(current_path).to eq('/items')
          end
        end
      end
    end
  end
end
