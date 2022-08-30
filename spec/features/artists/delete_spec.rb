# Parent Delete 

# As a visitor
# When I visit a parent show page
# Then I see a link to delete the parent
# When I click the link "Delete Parent"
# Then a 'DELETE' request is sent to '/parents/:id'
# the parent is deleted
# and all child records are deleted
# and I am redirected to the parent index page where I no longer see this parent

require 'rails_helper'

RSpec.describe 'Artist delete' do
  describe 'As a visitor' do
    describe 'When I visit the Parent show page' do
      describe 'Then I see a link to delete Parent record "Delete Parent"' do
        before :each do
          @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                     accepts_returns: false)
          @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                     accepts_returns: true)
          @item_1 = @artist_1.items.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                                            stock: 100, num_sold: 3, free_shipping: true)
          @item_2 = @artist_2.items.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                                            stock: 5, num_sold: 59, free_shipping: true)
        end

        it "visit '/artists/:id'" do
          visit "/artists/#{@artist_1.id}"

          expect(page).to have_button('Delete Artist')
        end

        describe 'When I click the button' do
          it "links to the new page from the artists index Then I am taken to '/parents'" do
            visit "/artists/#{@artist_1.id}"

            click_button('Delete Artist')
            expect(current_path).to eq("/artists")
          end

          it 'where I see the parent is deleted' do
            visit "/artists/#{@artist_1.id}"

            click_button('Delete Artist')
            visit "/artists"

            expect(page).to_not have_content(@artist_1.username)
          end

          it 'and all child records are deleted' do
            visit "/artists/#{@artist_1.id}"

            click_button('Delete Artist')
            visit "/items"
            
            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.price)
            expect(page).to_not have_content(@item_1.stock)
            expect(page).to_not have_content("Number Sold: #{@item_1.num_sold}")
            expect(page).to have_content(@item_2.rating)
            expect(page).to have_content(@item_2.price)
            expect(page).to have_content(@item_2.stock)
            expect(page).to have_content(@item_2.num_sold)
          end
        end
      end
    end
  end
end
