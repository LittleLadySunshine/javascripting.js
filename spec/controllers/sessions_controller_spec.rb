require 'rails_helper'

describe SessionsController do

  describe '#create' do
    it 'redirects to the ember app url if the src is ember' do
      user = create_instructor

      request.env['omniauth.auth'] = OmniAuth::AuthHash.new({
        provider: 'github',
        uid: '123545',
        credentials: OmniAuth::AuthHash.new(token: 'abc123'),
        info: {
          email: user.email,
          nickname: user.github_username,
        }
      })

      request.env['omniauth.params'] = {'src' => 'ember'}

      get :create, provider: "github"

      expect(response).to redirect_to(ENV['EMBER_APP_URL'])
    end
  end

end
