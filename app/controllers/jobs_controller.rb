require 'pry'

class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:new, :create]

  def index
    if params[:company_id].nil? && params[:sort] == "location"
      @jobs = Job.location_sort
      render :index_sort_location
    elsif params[:company_id].nil? && params[:sort] == "interest"
      @jobs = Job.sort_by_interest
      render :index_by_interest
    elsif params[:company_id].nil? && params[:location]
      @jobs = Job.find_by_location(params[:location])
      render :jobs_by_location
    else
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
      @contact = @company.contacts.new
    end
  end

  def new
    @categories = Category.all
    @jobs = Job.new
  end

  def create
    @category = Category.find(params[:job][:category_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      @category.jobs.push(@job)
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def show
    @category = @job.category
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    @company = @job.company
    @categories = Category.all
  end

  def update
    @company = @job.company
    @job.update(job_params)

    redirect_to company_jobs_path(@company)
  end

  def destroy
    @company = @job.company
    @job.destroy

    redirect_to company_jobs_path(@company)
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def job_params
    params.require(:job).permit(:title,
                                :description,
                                :level_of_interest,
                                :city,
                                :category_id)
  end
end
