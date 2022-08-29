# Parent Update 

# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/parents/:id'
# the parent's info is updated
# and I am redirected to the Parent's Show page where I see the parent's updated info

RSpec.describe 'Artist update' do
  describe 'As a visitor' do
    describe 'When I visit the Parent show page' do
      describe 'Then I see a link to update Parent record "Update Parent"' do
        before :each do
          @artist_1 = Artist.create!(username: 'Hummus Scultpures', location: 'Taos, NM', followers: 42,
                                     accepts_returns: false)
        end

        it "visit '/artists/:id'" do
          visit "/artists/#{@parent_1.id}"

          expect(page).to have_button('Update Artist')
        end

        describe 'When I click this link' do
          it "links to the new page from the artists index Then I am taken to '/parents/new'" do
            visit '/artists'

            click_link('Update Artist')
            expect(current_path).to eq("/artists/#{@parent_1.id}/edit")
          end

          it 'where I see a form to edit parent record' do
            visit "/artists/#{@parent_1.id}/edit"

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

          it 'can update an artist and redirects to artist show' do
            visit "/artists/#{@parent_1.id}/edit"

            fill_in('Username', with: 'Hummus Creations')
            fill_in('Location', with: 'Taos, New Mexico')
            fill_in('Followers', with: '420')
            choose('Yes')
            click_button('Update Artist')

            expect(current_path).to eq("/artists/#{@parent_1.id}")
          end

          it 'saves entered info' do
            visit "/artists/#{@parent_1.id}/edit"

            fill_in('Username', with: 'Hummus Creations')
            fill_in('Location', with: 'Taos, New Mexico')
            fill_in('Followers', with: '420')
            choose('Yes')
            click_button('Update Artist')

            expect(page).to have_content('Hummus Creations')
            expect(page).to have_content('Taos, New Mexico')
            expect(page).to have_content('420')
            expect(page).to have_content('true')
          end
        end
      end
    end
  end
end