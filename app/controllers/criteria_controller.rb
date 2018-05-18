class CriteriaController < ApplicationController


	def index
		#@criteria = Criterium.all

        # не выводит "коренные" критерии

		if params[:t] # если параметр t определен
			@task_num = params[:t] # передаем параметр t
		else
			task = Task.take # передаем первую запись из таблицы как параметры
			@task_num = task.id
		end 


		@criteria = Criterium.where("criterium_id != ? AND task_id = ?", 1, @task_num)

		#@task_num = params[:t]

		#@criterium = Criterium.where("task_id = ?", params[:task_id])

		
		
	end

	def new
		@criterium = Criterium.new

		@task_num = params[:t] #номер задачи, для которой добавляются критерии
	end

	def edit
		@criterium = Criterium.find(params[:id])

		@task_num = params[:t]

		@crit_scale = CritScale.where(criterium_id: @criterium).order(:rank)
	end

	def create

		@parent_crit = Criterium.find(params[:criterium][:criterium_id])

		@criterium = Criterium.new(task_id: @parent_crit.task_id, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, rank: @parent_crit.rank + 1, ismin: params[:criterium][:ismin], idealvalue: params[:idealvalue], ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord])

		if @criterium.save
	    	redirect_to criteria_path(t: @parent_crit.task_id) #@criterium
		else
			render 'new'
		end


	end

	def update
		@parent_crit = Criterium.find(params[:criterium][:criterium_id])

		@criterium = Criterium.find(params[:id])

		if @criterium.update(task_id: @parent_crit.task_id, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, rank: @parent_crit.rank + 1, ismin: params[:criterium][:ismin], idealvalue: params[:idealvalue], ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord])
			redirect_to criteria_path(t: @parent_crit.task_id)
		else
			render 'edit'
		end
	end

	def destroy
		@criterium = Criterium.find(params[:id])

		@critscales = CritScale.where(criterium_id: @criterium.id)

		@critscales.each do |cs|
			cs.destroy
		end

		@criterium.destroy

		redirect_to criteria_path
	end

	def crit_scale_new
		@critscale = CritScale.new
	end

	def crit_scale_create
		#@crit = Criterium.find(1) #корневой критерий, который поменяется на созданный новый критерий
        # criterium_id не должен равняться 1, исправить!
		@critscale = CritScale.new(criterium_id: params[:c], name: params[:name], rank: params[:rank])

		if @critscale.save
			@crit = Criterium.find(params[:c])
			redirect_to edit_criterium_path(t: @crit.task_id)
		else
			render 'crit_scale_new'
		end
	end

	def crit_scale_destroy
		@critscale = CritScale.find(params[:id])

		@crit = @critscale.criterium_id
		@cr = Criterium.find(@crit)


		@critscale.destroy


		redirect_to edit_criterium_path(@crit, t: @cr.task_id)
	end

    #исправить!!! номер задачи, для которой добавляются критерии
	def task_num
		@task = params[:criterium][:task_id]
		redirect_to criteria_path(t: @task)

		#return @task #@num_task
	end


   




	private
	    def criterium_params
	    	params.require(:criterium).permit(:task_id, :description, :name, :criterium_id, :rank, :ismin, :idealvalue, :ws_method_id, :ord)

	    	#:task_id, :description, :name, :criterium_id, :rank, :ismin, :idealvalue, :ws_method_id, :ord
	    end

	private 



	def crit_tree(taskid, rank)
		res = ""
		rank = rank + 1
		crit_array = Criterium.where("rank = ? AND task_id = ?", rank, taskid).order(:ord)
		crit_array.each do |cr|
			res = "<li>#{cr.name}"
			res << "<ul>"
			res << crit_tree(taskid, rank)
			res << "</ul>"
			res << "</li>"
		end
		res
	end

    def tree(taskid, rank)
    	"<ul>#{crit_tree(taskid, rank)}</ul>".html_safe
    end


    
end
