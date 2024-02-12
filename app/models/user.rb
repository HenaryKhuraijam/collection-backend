class User < ApplicationRecord
  has_one_attached :avatar_img
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end

  def as_json(options = {})
    super(options.merge(methods: [:avatar]))
  end

  def avatar
    avatar_img.attached? ? Rails.application.routes.url_helpers.rails_blob_url(avatar_img) : nil
  end
end
