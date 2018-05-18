class CritValuesController < ApplicationController
	def index
		#@alternative = Alternative.find(params[:id])

		#@critvalues = CritValue.where(alternative_id: @alternative.id)

		#@critvalues = CritValue.all

		@alternative = Alternative.find(params[:a])
		@criteria = Criterium.where("task_id = ? AND rank != ?", @alternative.task_id, 0)
	end

	def create
		@critvalue = CritValue.new(criterium_id: params[:c], alternative_id: params[:a], crit_scale_id: 1, value: 22)

		@critvalue.save

		redirect_to crit_values_path(a: params[:a])
		
	end
end
