class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    render json: {
      status: 200,
      message: 'Login in successfull',
      user: resource
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: { status: 200, message: 'Signed out successfully' }, status: :ok
    else
      render json: {
        status: 401,
        message: 'User not active'
      }, status: :unauthorized
    end
  end
end
