class JobsController < ApplicationController
  before_action :set_job ,only: [:show,:edit,:update,:destroy]
  before_action :authenticate_user! ,only: [:new,:edit,:destroy,:update,:create]



  def index
    if(params.has_key?(:job_type))
      @job = Job.where(job_type: params[:job_type]).order("created_at desc")
    else
      @job = Job.all.order("created_at desc")
    end
  end


  def show

  end

  def new
  	@job = current_user.jobs.build
  end

  def create 
  	@job  = current_user.jobs.build(job_params)
  	if @job.save 
  		redirect_to @job
  	else
  		redirect_to "new"
  	end

  end 

  def edit

  end

  def update
  	if @job.update(job_params);
  		redirect_to :root
  	end
  end 

  def destroy 
  	@job.destroy 
  	redirect_to :root
  end 

  private 

  def job_params
  	params.require(:job).permit(:title,:description,:url,:job_type,:location,:job_author,:remote_ok,:apply_url,:avatar)
  end

  def set_job
  	@job = Job.find(params[:id])
  end

end
