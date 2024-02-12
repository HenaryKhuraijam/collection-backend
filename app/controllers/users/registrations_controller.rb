# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: 200, message: 'Signed up successfully',
        data: resource }, status: :ok
    else
      render json: {
        status: 422, message: 'Registration Failed!',
        errors: resource.errors.full_messages
      },
      status: :unprocessable_entity
    end
  end
end
