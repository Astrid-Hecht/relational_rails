# Child Update

# As a visitor
# When I visit a Child Show page
# Then I see a link to update that Child "Update Child"
# When I click the link
# I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
# When I click the button to submit the form "Update Child"
# Then a `PATCH` request is sent to '/child_table_name/:id'
# the child's data is updated
# and I am redirected to the Child Show page where I see the Child's updated information
# ActiveRecord

require 'rails_helper'

RSpec.describe 'Item update' do
  describe 'As a visitor' do
    describe 'When I visit the Item show page' do
      describe 'Then I see a link to update Item record "Update Item"' do
        before :each do
          @artist_1 = Artist.create(username: 'Hummus Scultpures', location: 'Taos, NM', followers: 42,
                                    accepts_returns: false)
          @item_1 = Item.create(name: 'Tremendous Tahini Trombone', rating: 1.0, price: 699.99,
                                stock: 2, num_sold: 1, free_shipping: false, artist_id: @artist_1.id)
        end

        it "visit '/items/:id'" do
          visit "/items/#{@item_1.id}"

          expect(page).to have_button('Update Item')
        end

        describe 'When I click this link' do
          it "links to the update page from the item index Then I am taken to '/items/:id/edit'" do
            visit "/items/#{@item_1.id}"

            click_link('Update Item')
            expect(current_path).to eq("/items/#{@item_1.id}/edit")
          end

          it 'where I see a form to edit Item record' do
            visit "/items/#{@item_1.id}/edit"

            expect(page).to have_field('Name')
            expect(page).to have_field('Rating')
            expect(page).to have_field('Price')
            expect(page).to have_field('Stock')
            expect(page).to have_field('num_sold')
            expect(page).to have_selector('#free_shipping_true')
            expect(page).to have_selector('#free_shipping_false')
          end

          # When I fill out the form with a new Item's attributes:
          # And I click the button "Create Item" to submit the form
          # Then a `POST` request is sent to the '/Items' route
          # a new Item record is created
          # and I am redirected to the Item Index page where I see the new Item displayed.

          it 'can update an item and redirects to item show' do
            visit "/items/#{@item_1.id}/edit"

            fill_in('Name', with: 'Tiny Tahini Trombone')
            fill_in('Rating', with: '3.5')
            fill_in('Price', with: '69.99')
            fill_in('Stock', with: '1')
            fill_in('num_sold', with: '0')
            choose('Free!')
            click_button('Update Item')

            expect(current_path).to eq("/items/#{@item_1.id}")
            expect(page).to have_content('Tiny Tahini Trombone')
            expect(page).to have_content('3.5')
            expect(page).to have_content('69.99')
            expect(page).to have_content('1')
            expect(page).to have_content('0')
            expect(page).to have_content('Free!')
          end
        end
      end
    end
  end
end
