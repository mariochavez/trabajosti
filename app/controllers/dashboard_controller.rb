class DashboardController < ApplicationController
  def index
    @jobs = Job.latest.limited
    @total = Job.latest.count
  end

  def all
    @jobs = Job.latest
    @action = 'all'

    render 'index'  
  end

  def show
    @job = Job.find params[:id] 
  end
end
