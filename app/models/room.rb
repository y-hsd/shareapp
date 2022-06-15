class Room < ApplicationRecord
    has_one_attached :image
    has_many :reservations, dependent: :destroy
    belongs_to :user

    validates :name, presence: true
    validates :address, presence: true
    validates :introduction, presence: true,length: { maximum: 20 }
    validates :price, presence: true

    def self.search(address,keyword)
        if address.present? && keyword.present?
            @rooms = Room.where(["address LIKE ?", "%#{address}%"]).where(["address LIKE ? OR name LIKE ? OR introduction LIKE ?","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
        elsif address.present?
            @rooms = Room.where(["address LIKE ?", "%#{address}%"])
        elsif keyword.present?
            @rooms = Room.where(["address LIKE ? OR name LIKE ? OR introduction LIKE ?","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
        else
            @rooms = Room.none
        end
    end

end
