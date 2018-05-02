class CriteriaController < ApplicationController


	def index
		#@criteria = Criterium.all

        # не выводит "коренные" критерии
		@criteria = Criterium.where("criterium_id != ?", 1)

		#@criterium = Criterium.where("task_id = ?", params[:task_id])
		
	end

	def new
		@criterium = Criterium.new

		@num_of_task = num_of_task #исправить!!! номер задачи, для которой добавляются критерии
	end

	def edit
		@criterium = Criterium.find(params[:id])

		@num_of_task = num_of_task

		@crit_scale = CritScale.where(criterium_id: num_of_crit).order(:rank)
	end

	def create

		@parent_crit = Criterium.find(params[:criterium][:criterium_id])

		@criterium = Criterium.new(task_id: num_of_task, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, rank: @parent_crit.rank + 1, ismin: params[:criterium][:ismin], idealvalue: params[:idealvalue], ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord])

		if @criterium.save
	    	redirect_to criteria_path #@criterium
		else
			render 'new'
		end
	end

	def update
		@parent_crit = Criterium.find(params[:criterium][:criterium_id])

		@criterium = Criterium.find(params[:id])

		if @criterium.update(task_id: num_of_task, description: params[:description], name: params[:name], criterium_id: @parent_crit.id, rank: @parent_crit.rank + 1, ismin: params[:criterium][:ismin], idealvalue: 0, ws_method_id: params[:criterium][:ws_method_id], ord: params[:ord])
			redirect_to criteria_path
		else
			render 'edit'
		end
	end

	def destroy
		@criterium = Criterium.find(params[:id])

		@criterium.destroy

		redirect_to criteria_path
	end

	def crit_scale_new
		@critscale = CritScale.new
	end

	def crit_scale_create
		#@crit = Criterium.find(1) #корневой критерий, который поменяется на созданный новый критерий
        # criterium_id не должен равняться 1, исправить!
		@critscale = CritScale.new(criterium_id: num_of_crit, name: params[:name], rank: params[:rank])

		if @critscale.save
			redirect_to edit_criterium_path
		else
			render 'crit_scale_new'
		end
	end

	def crit_scale_destroy
		@critscale = CritScale.find(params[:id])

		@crit = @critscale.criterium_id

		@critscale.destroy


		redirect_to edit_criterium_path(@crit)
	end

    #исправить!!! номер задачи, для которой добавляются критерии
	def num_of_task

		#@num_task = params[:criterium][:task_id]

		return 87 #@num_task
	end


    #исправить!!! номер критерия, для которого выводится шкала
	def num_of_crit
		return 17
	end




	private
	    def criterium_params
	    	params.require(:criterium).permit(:task_id, :description, :name, :criterium_id, :rank, :ismin, :idealvalue, :ws_method_id, :ord)

	    	#:task_id, :description, :name, :criterium_id, :rank, :ismin, :idealvalue, :ws_method_id, :ord
	    end

	private 

    
end
