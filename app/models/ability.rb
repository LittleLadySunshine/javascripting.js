class Ability

  PERMISSIONS = {
    instructor: {
      manage: {
        daily_plans: true
      },
    },
  }

  attr_reader :user
  private :user

  def initialize(user)
    @user = user
  end

  def can?(verb, noun)
    return false unless @user
    PERMISSIONS.fetch(user.role.to_sym, {}).fetch(verb, {}).fetch(noun, false)
  end

end
