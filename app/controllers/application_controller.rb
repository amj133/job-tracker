class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def dashboard
    @job_count_by_interest = Job.count_by_interest
    @top_3_by_avg_interest = Company.top_3_by_avg_interest
    @job_count_by_location = Job.count_by_location
  end
end
