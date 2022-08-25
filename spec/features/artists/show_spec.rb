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
    end
  end
end
