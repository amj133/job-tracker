require 'pry'

class JobsController < ApplicationController
  # before_action :set_job, only: [:show, :destroy, :edit, :update]

  def index
    if params[:company_id].nil?
      @jobs = Jobs.all
      render :index_by_location
    else
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
      # @contact = Contact.new
      @contact = @company.contacts.new
    end
  end

  def new
    @categories = Category.all
    @company = Company.find(params[:company_id])
    @jobs = Job.new()
  end

  def create
    @company = Company.find(params[:company_id])
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
    # @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @category = @job.category
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    # @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @company = @job.company
    @categories = Category.all
  end

  def update
    # @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @company = @job.company
    @job.update(job_params)

    redirect_to company_jobs_path(@company)
  end

  def destroy
    # @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
    @company = @job.company
    # @job.comments.destroy
    @job.destroy

    redirect_to company_jobs_path(@company)
  end

  private

  def job_params
    params.require(:job).permit(:title,
                                :description,
                                :level_of_interest,
                                :city,
                                :category_id)
  end
end
