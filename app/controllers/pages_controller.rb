class PagesController < ApplicationController
  def home
    @team = TeamOptimizer.create_team
  end
end
