class CommunityController < ApplicationController
  
  def index
    @experience = Refinery::Experiences::Experience.new
    @idea = Refinery::Ideas::Idea.new
    @ideas = Refinery::Ideas::Idea.order('position ASC')
    @experiences = Refinery::Experiences::Experience.order('position ASC')
  end
end
