class CritValuesController < ApplicationController
	def index
		#@alternative = Alternative.find(params[:id])

		#@critvalues = CritValue.where(alternative_id: @alternative.id)

		@critvalues = CritValue.all
	end

	def new
		@critvalue = CritValue.new
	end

	def create
		@critvalue = CritValue.new(criterium_id: params[:critvalue][:criterium_id], alternative_id: params[:critvalue][:alternative_id], crit_scale_id: nil, value: params[:value])


		if @critvalue.save
	    	redirect_to crit_values_path
		else
			render 'new'
		end
	end
end
