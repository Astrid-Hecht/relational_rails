class Item < ApplicationRecord
  belongs_to :artist

  def self.true_select
    self.where(free_shipping: true)
  end

  def self.ordered
    self.order(:name)
  end
end