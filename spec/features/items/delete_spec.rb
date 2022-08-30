# Child Delete

# As a visitor
# When I visit a child show page
# Then I see a link to delete the child "Delete Child"
# When I click the link
# Then a 'DELETE' request is sent to '/child_table_name/:id'
# the child is deleted
# and I am redirected to the child index page where I no longer see this child

require 'rails_helper'

RSpec.describe 'Item delete' do
  describe 'As a visitor' do
    describe 'When I visit the Child show page' do
      describe 'Then I see a link to delete Child record "Delete Child"' do
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

        it "visit '/items/:id'" do
          visit "/items/#{@item_1.id}"

          expect(page).to have_button('Delete Item')
        end

        describe 'When I click this link' do
          it "deletes the item and sends to item index" do
            visit "/items/#{@item_1.id}"

            click_button('Delete Item')
            expect(current_path).to eq("/items")
          end

          it 'where I see the Child is deleted' do
            visit "/items/#{@item_1.id}"

            click_button('Delete Item')
            visit "/items"

            expect(page).to_not have_content(@item_1.name)
          end

          it 'and all child records are deleted' do
            visit "/items/#{@item_1.id}"

            click_button('Delete Item')
            visit "/items"

            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.price)
            expect(page).to_not have_content(@item_1.stock)
            expect(page).to_not have_content("Number Sold: #{@item_1.num_sold}")
            expect(page).to have_content(@item_2.rating)
            expect(page).to have_content(@item_2.rating)
            expect(page).to have_content(@item_2.price)
            expect(page).to have_content(@item_2.stock)
            expect(page).to have_content(@item_2.num_sold)

            visit "/artists/#{@artist_1.id}/items"
            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.rating)
            expect(page).to_not have_content(@item_1.price)
            expect(page).to_not have_content(@item_1.stock)
            expect(page).to_not have_content("Number Sold: #{@item_1.num_sold}")
          end
        end
      end
    end
  end
end