# Parent Creation

# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record
# "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route
# a new parent record is created
# and I am redirected to the Parent Index page where I see the new Parent displayed.

require 'rails_helper'

RSpec.describe 'Artist creation' do
  describe 'As a visitor' do
    describe 'When I visit the Parent Index page' do
      describe 'Then I see a link to create a new Parent record "New Parent"' do
        it "visit '/artists'" do
          visit '/artists'

          expect(page).to have_button('New Artist')
        end

        describe 'When I click this link' do
          it "links to the new page from the artists index Then I am taken to '/parents/new'" do
            visit '/artists'

            click_link('New Artist')
            expect(current_path).to eq('/artists/new')
          end

          it 'where I see a form for a new parent record' do
            visit '/artists/new'

            expect(page).to have_field('Username')
            expect(page).to have_field('Location')
            expect(page).to have_field('Followers')
            expect(page).to have_selector('#accepts_returns_true')
            expect(page).to have_selector('#accepts_returns_false')
          end

          # When I fill out the form with a new parent's attributes:
          # And I click the button "Create Parent" to submit the form
          # Then a `POST` request is sent to the '/parents' route
          # a new parent record is created
          # and I am redirected to the Parent Index page where I see the new Parent displayed.

          it 'can create a new artist and redirects to artist index' do
            visit '/artists/new'

            fill_in('Username', with: 'Hummus Scultpures')
            fill_in('Location', with: 'Taos, NM')
            fill_in('Followers', with: '42')
            choose('No')
            click_button('Create Artist')
          end

          it 'saves entered info' do
            visit '/artists/new'

            fill_in('Username', with: 'Hummus Scultpures')
            fill_in('Location', with: 'Taos, NM')
            fill_in('Followers', with: '42')
            choose('No')
            click_button('Create Artist')

            click_link("Hummus Scultpures")
            expect(page).to have_content('Hummus Scultpures')
            expect(page).to have_content('Taos, NM')
            expect(page).to have_content('42')
            expect(page).to have_content('false')
          end
        end
      end
    end
  end
end
