module PriceCalculator
	# For Home Cleanings
	def self.home_cleaning(params)
		calculate_hc_time(params)
		calculate_hc_providers(params)
		if params[:bedrooms] == 2 && params[:bathrooms] == 2 && params[:kitchens] == 1 && params[:livingrooms] == 1
			@quote = 1000
			@quote += params[:loads] * 350
			@quote += params[:ironed] * 300
			@quote += ((@providers - 1) * 300)
		elsif params[:bedrooms] == 3 && params[:bathrooms] == 3 && params[:kitchens] == 1 && params[:livingrooms] == 1
			@quote = 1500
			@quote += params[:loads] * 350
			@quote += params[:ironed] * 300
			@quote += ((@providers - 1) * 300)
		else
			@quote = params[:bedrooms] * 400
			@quote += params[:bathrooms] * 200
			@quote += params[:kitchens] * 300
			@quote += params[:livingrooms] * 300
			@quote += params[:loads] * 350
			@quote += params[:ironed] * 300
			@quote += (@providers - 1) * 300
		end
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_hc_time(params)
		@time = params[:bedrooms] * 0.50
		@time += params[:bathrooms] * 0.50
		@time += params[:kitchens] * 1.00
		@time += params[:livingrooms] * 0.50
		@time += params[:loads] * 4.00
		@time += params[:ironed] * 4.00
	end

	def self.calculate_hc_providers(params)
		@providers = (params[:bedrooms] / 3.0).ceil
	end

# For Office Cleaning
	def self.office_cleaning(params)
		calculate_oc_time(params)
		calculate_oc_providers(params)
		@quote = params[:sqft] * 2
		@quote += 300 if params[:kitchen] 
		@quote += (@providers - 1) * 400
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_oc_time(params)
		@time = params[:sqft] / 250.00
	end

	def self.calculate_oc_providers(params)
		@providers = ((params[:sqft] - 500) / 1000).ceil + 1
	end

	# For Car Wash
	def self.car_wash(params)
		calculate_cw_time(params)
		calculate_cw_providers(params)
		@quote = params[:cars] * 500
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_cw_time(params)
		@time = params[:cars]
	end

	def self.calculate_cw_providers(params)
		@providers = params[:cars]
	end

	# For Drivers
	def self.driver(params)
		calculate_d_time(params)
		calculate_d_providers(params)
		@quote = 0
		params[:cars].each do |car|
			if car[:owned] == 'true'
				@quote += 200 if car[:day_or_night].to_i == 0
				car[:hours] >= 12.00 ? (@quote += (car[:hours] - 12.00) * 300 + 1500) : (@quote += car[:hours] * 300)  
			else
				@quote += 200 if car[:day_or_night].to_i == 0
				car[:wheel_type].to_i == 0 ? @quote += 3500 : @quote += 7000
				car[:hours] >= 12.00 ? (@quote += (car[:hours] - 12.00) * 300 + 1500) : (@quote += car[:hours] * 300)
			end
		end
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_d_time(params)
		@time = 0
		params[:cars].each do |car|
			@time += car[:hours]
		end
	end

	def self.calculate_d_providers(params)
		@providers = params[:cars].size
	end

	# For Security
	def self.security(params)
		calculate_sc_time(params)
		calculate_sc_providers(params)
		@quote = 0
		params[:guards].each do |guard|
			if guard[:type].to_i == 0
				@quote += 1500
				@quote += (((guard[:hours] / 12.00).ceil - 1.00) * 1500)
			else
				@quote += 3000
				@quote += (((guard[:hours] / 12.00).ceil - 1.00) * 3000)
			end
		end
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_sc_time(params)
		@time = 0
		params[:guards].each do |guard|
			@time += guard[:hours]
		end
	end

	def self.calculate_sc_providers(params)
		@providers = params[:guards].size
	end

	# For Chef
	def self.chef(params)
		calculate_chef_time(params)
		calculate_chef_providers(params)
		@quote = 1500
		@quote += (@providers - 1) * 1200
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_chef_time(params)
		@time = 8.00
	end

	def self.calculate_chef_providers(params)
		@providers = ((params[:serving_size] - 15) / 10.00).ceil + 1
	end

	# For Gardening
	def self.gardening(params)
		calculate_gd_time(params)
		calculate_gd_providers(params)
		@quote = (params[:acres] / 0.50 ) * 1500
		return { quote: @quote, time: @time, providers: @providers }
	end

	def self.calculate_gd_time(params)
		@time = params[:acres] * 4.0
	end

	def self.calculate_gd_providers(params)
		@providers = (params[:acres] / 1.00).ceil
	end

	# For Contractor
	# def self.contractor
		# return { @quote: nil, @time: nil, @providers: nil }
	# end
end