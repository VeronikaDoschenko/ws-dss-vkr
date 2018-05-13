class AlternativesController < ApplicationController
	def index
		@alternatives = Alternative.all #where(task_id: task_num)

	end

	def new
		@alternative = Alternative.new
	end

	def edit
		@alternative = Alternative.find(params[:id])
	end

	def create
		@alternative = Alternative.new(task_id: params[:alternative][:task_id], name: params[:name], rank: params[:rank])

		if @alternative.save
	    	redirect_to alternatives_path
		else
			render 'new'
		end
	end

	def update
		@alternative = Alternative.find(params[:id])

		if @alternative.update(task_id: params[:alternative][:task_id], name: params[:name], rank: params[:rank])
			redirect_to alternatives_path
		else
			render 'edit'
		end
	end


	#def task_num
	#	return params[:alternative][:task_id]
	#end


end
