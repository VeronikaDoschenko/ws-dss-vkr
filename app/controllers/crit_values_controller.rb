class CritValuesController < ApplicationController
	def index
		#@alternative = Alternative.find(params[:id])

		#@critvalues = CritValue.where(alternative_id: @alternative.id)

		#@critvalues = CritValue.all

		@alternative = Alternative.find(params[:a])
		@criteria = Criterium.where("task_id = ? AND rank != ?", @alternative.task_id, 0)

		#@critvalue = CritValue.new
	end

	def create
		#@critscale = CritScale.where(criterium_id: params[:c]).take
		@crit_value_prev = CritValue.where(criterium_id: params[:c], alternative_id: params[:a]).take
		@crit_scale_exist = CritScale.where(criterium_id: params[:c]).take
		
		if @crit_value_prev != nil
			if @crit_scale_exist != nil
				@crit_value_prev = CritValue.update(criterium_id: params[:c], alternative_id: params[:a], crit_scale_id: params[:crit_value][:crit_scale_id], value: params[:value])
			else
				@crit_value_prev = CritValue.update(criterium_id: params[:c], alternative_id: params[:a], crit_scale_id: 1, value: params[:value])
			end
		else
			if @crit_scale_exist != nil
				@critvalue = CritValue.new(criterium_id: params[:c], alternative_id: params[:a], crit_scale_id: params[:crit_value][:crit_scale_id], value: params[:value])
			else
				@critvalue = CritValue.new(criterium_id: params[:c], alternative_id: params[:a], crit_scale_id: 1, value: params[:value])
			end
			@critvalue.save
		end

		redirect_to crit_values_path(a: params[:a])

	end
end
