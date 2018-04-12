class CriteriaController < ApplicationController
	def index
		@criteria = Criterium.all

		#@task = Task.all

		#name_mas = Array.new #cоздание пустого массива
        # заполнение массива
        #i = 0
		#@task.each do |t|
		#	name_mas[i] = t.name
		#	i = i + 1
		#end
	end

	def new
		@criterium = Criterium.new
	end

	def create
		@criterium = Criterium.new(criterium_params)

		if @criterium.save
			redirect_to criteria_path
		else
			render 'new'
		end
	end

	private
	    def criterium_params
	    	params.require(:criterium).permit(:task_id, :description, :name, :criterium_id, :rank, :ismin, :idealvalue, :ws_method_id, :ord)
	    end
end
