class ChargesController < ApplicationController

	def create
		@amount = 500

		customer = Stripe::Customer.create(:email => params[:stripeEmail],:source => params[:stripeTocken])
		
		charge = Stripe::Charge.create(:customer => customer.id, :amount => @amount ,:description => 'Rails stripe customer',:currency => 'usd' )		
		
		rescue Stripe::CardError => e 
			flash[:error] = e.message
			redirect_to new_charge_path
		end
	end
end
