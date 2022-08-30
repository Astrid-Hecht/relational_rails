require 'rails_helper'

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

RSpec.describe 'Artists#index', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit "/artists"' do
      before :each do
        @artist_1 = Artist.create!(username: 'UnnecessaryilyResin', location: 'Laramie, Wyoming', followers: 157,
                                  accepts_returns: false)
        @artist_2 = Artist.create!(username: 'PetHats', location: 'San Fransisco, California', followers: 40_378,
                                  accepts_returns: true)

        visit '/artists'
      end

      it 'Then I see the name of each artist record in the system' do
        expect(page).to have_content(@artist_1.username)
        expect(page).to have_content(@artist_2.username)
      end

      it 'only shows name' do
        expect(page).to_not have_content(@artist_1.location)
        expect(page).to_not have_content(@artist_2.location)
        expect(page).to_not have_content(@artist_1.followers)
        expect(page).to_not have_content(@artist_2.followers)
        expect(page).to_not have_content(@artist_1.accepts_returns)
        expect(page).to_not have_content(@artist_2.accepts_returns)
      end

      # I see that records are ordered by most recently created first
      # And next to each of the records I see when it was created

      it 'I see that records are ordered by most recently created first' do
        within '#artist_list' do
          expect(page.all('.artist')[0]).to have_content(@artist_2.username)
          expect(page.all('.artist')[1]).to have_content(@artist_1.username)
        end
      end

      it 'And next to each of the records I see when it was created' do
        within '#artist_list' do
          expect(page.all('.artist')[0]).to have_content(@artist_2.created_at.to_s)
          expect(page.all('.artist')[1]).to have_content(@artist_1.created_at.to_s)
        end
      end

      it 'every artist has an update button that takes you to edit page when clicked' do
        expect(page).to have_button('Edit Artist')
        expect(page.all('.artist')[0]).to have_button('Edit Artist')
        expect(page.all('.artist')[1]).to have_button('Edit Artist') 
        within(page.all('.artist')[0]) do
          click_link('Edit Artist')
        end
        expect(current_path).to eq("/artists/#{@artist_2.id}/edit")
      end

      it 'every artist has an delete button that deletes artist when clicked' do
        expect(page.all('.artist')[0]).to have_button('Delete Artist')
        expect(page.all('.artist')[1]).to have_button('Delete Artist') 
        within(page.all('.artist')[0]) do
          click_button('Delete Artist')
        end
        refresh
        expect(page).to_not have_content(@artist_2.username)
      end
    end
  end
end
