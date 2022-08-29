# Parent Child Creation

# As a visitor
# When I visit a Parent Children Index page
# Then I see a link to add a new adoptable child for that parent "Create Child"
# When I click the link
# I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
# When I fill in the form with the child's attributes:
# And I click the button "Create Child"
# Then a `POST` request is sent to '/parents/:parent_id/child_table_name'
# a new child object/row is created for that parent
# and I am redirected to the Parent Childs Index page where I can see the new child listed

require 'rails_helper'

RSpec.describe 'Item creation' do
  describe 'As a visitor' do
    describe 'When I visit the Artist Items Index page' do
      describe 'Then I see a link to add a new adoptable child for that parent "Create Child"' do
        before :each do
          @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                     accepts_returns: false)
        end

        it 'visit Artist Items Index' do
          visit "artists/#{@artist_1.id}/items"

          expect(page).to have_button('Create Item')
        end

        describe 'When I click the link' do
          it "I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child" do
            visit "/artists/#{@artist_1.id}/items"

            click_link('Create Item')
            expect(current_path).to eq("/artists/#{@artist_1.id}/items/new")
          end

          it 'where I see a form for a new parent record' do
            visit "/artists/#{@artist_1.id}/items/new"

            expect(page).to have_field('Name')
            expect(page).to have_field('Rating')
            expect(page).to have_field('Price')
            expect(page).to have_field('Stock')
            expect(page).to have_field('Number Sold')
            expect(page).to have_select('Free Shipping')
          end

          # When I fill out the form with a new parent's attributes:
          # And I click the button "Create Parent" to submit the form
          # Then a `POST` request is sent to the '/parents' route
          # a new parent record is created
          # and I am redirected to the Parent Index page where I see the new Parent displayed.

          it 'can create a new Item and redirects to Item index' do
            visit '/items/new'

            fill_in('Name', with: 'Tiny Tahini Trombone')
            fill_in('Rating', with: '3.5')
            fill_in('Price', with: '69')
            fill_in('Stock', with: '1')
            fill_in('Number Sold', with: '0')
            choose('Yes')
            click_button('Create Item')

            expect(current_path).to eq("/artists/#{@artist_1.id}/items")
            expect(page).to have_content('Hummus Scultpures')
            expect(page).to have_content('Tiny Tahini Trombone')
            expect(page).to have_content('3.5')
            expect(page).to have_content('69')
            expect(page).to have_content('1')
            expect(page).to have_content('0')
            expect(page).to have_content('Free!')
          end
        end
      end
    end
  end
end
