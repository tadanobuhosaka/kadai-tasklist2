class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :edit]
  

  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "Task create"
      redirect_to @task
    else
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
  
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
