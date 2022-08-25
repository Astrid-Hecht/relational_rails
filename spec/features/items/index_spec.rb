require 'rails_helper'

# User Story 3, Child Index 

# As a visitor
# When I visit '/child_table_name'
# Then I see each Child in the system including the Child's attributes:

RSpec.describe 'Item#index' do
  describe 'as a visitor' do
    describe 'when I visit "/items"' do
      before :each do
        @item_1 = Item.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                              stock: 100, num_sold: 3, free_shipping: true)
        @item_2 = Item.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                              stock: 5, num_sold: 59, free_shipping: false)

        visit '/items'
      end

      it 'Then I see each item in the system including the items attributes' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_1.rating)
        expect(page).to have_content(@item_2.rating)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@item_1.stock)
        expect(page).to have_content(@item_2.stock)
        expect(page).to have_content(@item_1.num_sold)
        expect(page).to have_content(@item_2.num_sold)
        expect(page).to have_content(@item_1.free_shipping)
        expect(page).to have_content(@item_2.free_shipping)
      end
    end
  end
end
