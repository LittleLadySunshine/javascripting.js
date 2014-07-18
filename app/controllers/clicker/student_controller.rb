module Clicker
  class StudentController < BaseController
    def show
      session[:uuid] = SecureRandom.uuid unless session[:uuid]
      sessions_repo.join(session[:uuid])
      @status = sessions_repo.find(session[:uuid])[:status]
    end

    def you_lost_me
      session[:uuid] = SecureRandom.uuid unless session[:uuid]
      sessions_repo.update_status(session[:uuid], Clicker::SessionRepo::BEHIND)
      render :status => :ok, :json => ""
    end

    def caught_up
      session[:uuid] = SecureRandom.uuid unless session[:uuid]
      sessions_repo.update_status(session[:uuid], Clicker::SessionRepo::CAUGHT_UP)
      render :status => :ok, :json => ""
    end
  end
end