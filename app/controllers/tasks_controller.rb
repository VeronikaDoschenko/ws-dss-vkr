class TasksController < ApplicationController
	def index
		@tasks = Task.all
	end

	def show
		@task = Task.find(params[:id])
	end

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find(params[:id])
    end

	def create

		@task = Task.new(task_params)

		/@ws_method = WsMethod.create(name: "Метод№2")/ 
		/@crireria = Criteria.create task_id: @task.id, description: "gg",  name: "Корень", criterium: @task.id, rank: 0, ismin: 1, idealvalue: 0, method_id: 1, ord: 1/

		if @task.save
			redirect_to @task
		else
			render 'new'
		end
	end

	def update
		@task = Task.find(params[:id])

		if @task.update(task_params)
			redirect_to @task
		else
			render 'edit'
		end
	end

	def destroy
		@task = Task.find(params[:id])

		@task.destroy

		redirect_to tasks_path
	end

	private
	    def task_params
	    	params.require(:task).permit(:name)
	    end
end