class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @total_contestants = @project.contestants.count
    @average_experience = @project.contestants.average(:years_of_experience)
  end
end