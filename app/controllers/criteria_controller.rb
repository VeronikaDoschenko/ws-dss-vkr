class CriteriaController < ApplicationController


	def index
		#@criteria = Criterium.all

        # не выводит "коренные" критерии

        @tasks = Task.all
        @tasks.each do |task|
        	if Criterium.where(task_id: task.id).take == nil
        		#@crit_root = Criterium.new(task_id: task.id, name: "Корень", criterium_id: 1, ws_method_id: 1, level: 0)
        		#@crit_root.save
        	end
        end

		if params[:t] # если параметр t определен
			@task_num = params[:t] # передаем параметр t
		else
			task = Task.take # передаем первую запись из таблицы как параметры
			@task_num = task.id
		end 

		@criteria_tree = criteria_tree(Criterium.find_by task_id: @task_num, level: 0)



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


 		@criterium = Criterium.new(task_id: @parent_crit.task_id, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, ismin: params[:criterium][:ismin], ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord], level: @parent_crit.level + 1)

		if @criterium.save
	    	redirect_to criteria_path(t: @parent_crit.task_id) #@criterium
		else
			render 'new'
		end


	end

	def update
		#@parent_crit = Criterium.find(params[:criterium][:criterium_id])

		@criterium = Criterium.find(params[:id])

		if params[:criterium][:criterium_id]
			@parent_crit = Criterium.find(params[:criterium][:criterium_id])
		else
			@parent_crit = Criterium.find(@criterium.criterium_id)
		end

		if params[:criterium][:rank]
		crit_rank = CritScale.find(params[:criterium][:rank])
		crit_rank = crit_rank.rank
	    end

		if @criterium.update(task_id: @parent_crit.task_id, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, rank: crit_rank, ismin: params[:criterium][:ismin], idealvalue: params[:idealvalue], ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord], level: @parent_crit.level + 1)
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

    #номер задачи, для которой добавляются критерии
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



	def tree(criterium)
		res = ""
		level = criterium.level + 1
		crit_array = Criterium.where("level = ? AND task_id = ? AND criterium_id = ?", level, criterium.task_id, criterium.id).order(:ord)
		crit_array.each do |cr|
			res << "<li>#{cr.name}"
			res << "#{view_context.link_to 'Выбрать', edit_criterium_path(cr, t: @task_num) }"
			res << "<ul>"
			res << tree(cr)
			res << "</ul>"
			res << "</li>"
		end
		res
	end

    def criteria_tree(criterium)
    	"<ul>#{tree(criterium)}</ul>".html_safe
    end

    #def children_tree(criterium)
   # 	crit_array = crit_array + Criterium.where("task_id != ? AND criterium_id = ?")
    #end

end

