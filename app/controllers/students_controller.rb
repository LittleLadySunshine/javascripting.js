class StudentsController < ApplicationController
  def show
    @student = User.find(params[:id])
  end
end
