class User < ApplicationRecord
  has_one_attached :avatar_img
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def as_json(options = {})
    super(options.merge(methods: [:avatar]))
  end
     
  def avatar
    avatar_img.attached? ? Rails.application.routes.url_helpers.rails_blob_url(avatar_img) : nil
  end
end
