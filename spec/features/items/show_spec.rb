require 'rails_helper'

# As a visitor
# When I visit '/child_table_name/:id'
# Then I see the child with that id including the child's attributes:

RSpec.describe 'items#show' do
  describe 'as a visitor' do
    describe 'When I visit "/items/:id"' do
      before :each do
        @item_1 = Item.create!(name: 'Resin Sparkle Beer Cozy', rating: 2.2, price: 44.95,
                              stock: 100, num_sold: 3, free_shipping: true)
        @item_2 = Item.create!(name: 'Boxer Bowler', rating: 5.0, price: 35.01,
                              stock: 5, num_sold: 59, free_shipping: false)

        visit "/items/#{@item_1.id}"
      end

      it 'Then I see the item with that id' do
        expect(page).to have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
      end

      it "including the items's attributes" do
        expect(page).to have_content(@item_1.rating)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.stock)
        expect(page).to have_content(@item_1.num_sold)
        expect(page).to have_content(@item_1.free_shipping)
      end
    end
  end
end
