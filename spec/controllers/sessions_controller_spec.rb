require 'rails_helper'

describe SessionsController do

  describe '#create' do
    it 'redirects to the ember app url if the src is ember' do
      request.env['omniauth.params'] = {'src' => 'ember'}

      get :create, provider: "github"

      expect(response).to redirect_to(ENV['EMBER_APP_URL'])
    end
  end

end
