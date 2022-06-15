class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar
  has_many :reservations
  has_many :rooms

       
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true #, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 },allow_blank: true #, format: { with: VALID_PASSWORD_REGEX }
  validates :introduction, length: { maximum: 200 } 
  attr_accessor :current_password

  def rooms
    return Room.where(user_id: self.id)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
