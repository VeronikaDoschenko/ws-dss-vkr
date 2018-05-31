class AlternativesController < ApplicationController
	def index
		#@alternatives = Alternative.where(task_id: params[:t]) # параметр t из url

         # если параметр t не пустой
		if params[:t]
			@alternatives = Alternative.where(task_id: params[:t])
		else
			@alternatives = Alternative.all.order(:task_id).order(:rank)#все отсортированно по пренадлежности к задаче
		end
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

	def destroy
		@alternative = Alternative.find(params[:id])

		@critvalue = CritValue.where(alternative_id: @alternative.id)

		@critvalue.each do |cv|
			cv.destroy
		end

		@alternative.destroy

		redirect_to alternatives_path
	end


	def task_num
	  @task = params[:alternative][:task_id]
	  redirect_to alternatives_path(t: @task)
	end


end
