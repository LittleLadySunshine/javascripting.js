module OmniauthHelpers
  def mock_user_login(user)
    mock_omniauth(:base_overrides => {:uid => user.github_id},
                  :info_overrides => {:email => user.email})
  end

  def mock_omniauth(base_overrides: {}, info_overrides: {})
    info_defaults = {
        email: 'user@example.com',
        :nickname => 'nickname'
    }

    base_defaults = {
      :provider => 'github',
      :uid => '123545',
      :info => info_defaults.merge(info_overrides)
    }
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(base_defaults.merge(base_overrides))
  end
end
