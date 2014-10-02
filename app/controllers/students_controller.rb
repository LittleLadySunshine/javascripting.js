class StudentsController < ApplicationController

  layout 'public'

  def show
    @student = User.find(params[:id])
  end
end
