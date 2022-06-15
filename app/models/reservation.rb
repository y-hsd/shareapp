class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guests, presence: true

  def amount_days
    total_days = (self.end_date.to_i - self.start_date.to_i)/86400
    if total_days < 1
      total_days = 1
    else
      return total_days
    end
  end
  
  def amount_price
    self.total_price = room.price.to_i * self.total_days.to_i
  end

end
