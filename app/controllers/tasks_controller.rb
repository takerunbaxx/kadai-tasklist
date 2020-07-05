class TasksController < ApplicationController
  
  def index
    @tasks=Task.all
  end
  
  def new
    @task=Task.new
  end
  
  def create
    @task=current_user.tasks.build(task_params)
    if @task.save
      flash[:success]="タスクを保存しました"
      redirect_to @task
    else
      flash.now[:danger]="タスクは保存されませんでした。"
      render :new
    end
  end
  
  def show
    @task=Task.find(params[:id])
  end
  
  def edit
    @task=Task.find(params[:id])
  end
  
  def update
    @task=current_user.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:success]="taskは正常に更新されました。"
      redirect_to @task
    else
      flash[:danger]="taskは更新されませんでした。"
      render :edit
    end
  end
  
  
  def destroy
    @task=Task.find(params[:id])
    @task.destroy
    flash[:success]="タスクは正常に削除されました。"
    redirect_to tasks_url
  end
  
  private
  
  def task_params
   return params.require(:task).permit(:status,:content)
  end
  
  def correct_user
    @task=current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_url
    end
  end

end
