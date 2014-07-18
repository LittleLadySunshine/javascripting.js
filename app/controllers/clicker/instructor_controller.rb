module Clicker
  class InstructorController < BaseController
    def show

    end

    def reset
      sessions_repo.delete_all
      render :status => :ok, :json => ""
    end

    def boot
      active_sessions = sessions_repo.active_sessions
      render :json => active_sessions
    end
  end
end