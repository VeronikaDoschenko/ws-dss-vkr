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

		/@ws_method = WsMethod.create(name: "Метод№3")/
		/@criterium = Criterium.create(task_id: @task.id, description: "Корень",  name: "Корень", criterium: @task.id, rank: 0, ismin: 0, idealvalue: 0, ws_method_id: 1, ord: 0)/


		if @task.save
			redirect_to @task
		else
			render 'new'
		end

		#@root = Criterium.find(1) #общий родитель для всех коренных критериев
		#@ws_method_root = WsMethod.find(1) #WsMethod.first #выбрать отсутствие метода (под идентификатором 1)
		
		
		@criterium = Criterium.new(task_id: @task.id, description: "Корень",  name: "Корень", criterium_id: 1, rank: 0, ismin: 0, idealvalue: 0, ws_method_id: 1, ord: 0)
		@criterium.save

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

		@criterium = Criterium.find_by task_id: @task.id, rank: 0
		@criterium.destroy #поиск и удаление корневого критерия по id задачи и рангу, равному 0

		@task.destroy



		redirect_to tasks_path
	end



	private
	    def task_params
	    	params.require(:task).permit(:name)
	    end


	#def taskid
	#	return 1
	#end
end
