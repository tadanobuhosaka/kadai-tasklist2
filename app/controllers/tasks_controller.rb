class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :edit]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "Task create"
      redirect_to @task
    else
      @tasklists = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "Couldnt create Task"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "edited Task"
      redirect_to @task
    else
      flash[:danger] = "Couldnt edit Task"
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = "delited Task"
    redirect_to tasks_path
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
