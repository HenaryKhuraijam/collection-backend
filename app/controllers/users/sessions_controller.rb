# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options={})
  render json: {
      status:200,
      message: 'Signed in successfully',
      user: resource
    }, status: :ok
  end
end
