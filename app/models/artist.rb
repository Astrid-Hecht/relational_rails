class Artist < ApplicationRecord
  has_many :items

  def self.recent
    self.order(created_at: :desc)
  end

  def tot_stock
    self.items.count
  end
end