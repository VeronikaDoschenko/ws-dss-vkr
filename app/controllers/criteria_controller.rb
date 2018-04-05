class CriteriaController < ApplicationController
	def index
		@criteria = Criterium.all
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
	    	params.require(:criterium).permit(:name, :description)
	    end
end
