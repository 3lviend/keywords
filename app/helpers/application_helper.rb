module ApplicationHelper

	# Total Number of Keywords #
	def overall_tnk(key_1, key_2)
		(key_1.size + key_2.size)
	end

	def new_queries_tnk(key_1, key_2)
		(key_1.find_all{|k|k if k.new}.size) + (key_2.find_all{|k|k if k.new}.size)
	end

	def existing_queries_tnk(key_1, key_2)
		(key_1.find_all{|k|k if !k.new}.size) + (key_2.find_all{|k|k if !k.new}.size)
	end

	# Visibility (current) #
	def overall_visbl(key_1, key_2)
		(key_1.map(&:impressions).inject{|sum,x| sum + x }) + (key_2.map(&:impressions).inject{|sum,x| sum + x })
	end

	def visibility_new_true(key_1, key_2)
		(key_1.find_all{|k|k if k.new}.sum(&:impressions)) + (key_2.find_all{|k|k if k.new}.sum(&:impressions))
	end

	def visibility_new_false(key_1, key_2)
		(key_1.find_all{|k|k if !k.new}.sum(&:impressions)) + (key_2.find_all{|k|k if !k.new}.sum(&:impressions))
	end

	def visibility_existing_true(key_2)
		key_2.find_all{|k|k if k.new}.sum(&:impressions)
	end

	def visibility_existing_false(key_2)
		key_2.find_all{|k|k if !k.new}.sum(&:impressions)
	end

	def overall_visibility_percentage(key_1, key_2)
		ovp = visibility_new_true(key_1, key_2) / overall_visbl(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def new_queries_visibility_percentage(key_1, key_2)
		ovp = visibility_existing_true(key_2) / visibility_new_true(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def existing_queries_percentage(key_1, key_2)
		ovp = visibility_existing_false(key_2) / visibility_new_false(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	# Traffic #
	def overall_traffic(key_1, key_2)
		key_1.map(&:clicks).inject{|sum,x| sum + x } + key_2.map(&:clicks).inject{|sum,x| sum + x }
	end

	def traffic_new_true(key_1, key_2)
		key_1.find_all{|k|k if k.new}.sum(&:clicks) + key_2.find_all{|k|k if k.new}.sum(&:clicks)
	end

	def traffic_new_false(key_1, key_2)
		key_1.find_all{|k|k if !k.new}.sum(&:clicks) + key_2.find_all{|k|k if !k.new}.sum(&:clicks)
	end

	def traffic_existing_true(key_2)
		key_2.find_all{|k|k if k.new}.sum(&:clicks)
	end

	def traffic_existing_false(key_2)
		key_2.find_all{|k|k if !k.new}.sum(&:clicks)
	end

	def overall_traffic_percentage(key_1, key_2)
		ovp = traffic_new_true(key_1, key_2) / overall_traffic(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def new_queries_traffic_percentage(key_1, key_2)
		ovp = traffic_existing_true(key_2) / traffic_new_true(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def existing_queries_traffic_percentage(key_1, key_2)
		ovp = traffic_existing_false(key_2) / traffic_new_false(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	# Average CTR #
	def overall_avg_ctr(key_1, key_2)
		(key_1.map(&:ctr).inject{|sum,x| sum + x } + key_2.map(&:ctr).inject{|sum,x| sum + x }) / (key_1.map(&:ctr).size + key_2.map(&:ctr).size)
	end

	def avg_ctr_new_true(key_1, key_2)
		(key_1.find_all{|k|k if k.new}.sum(&:ctr) + key_2.find_all{|k|k if k.new}.sum(&:ctr)) / (key_1.find_all{|k|k if k.new}.size + key_2.find_all{|k|k if k.new}.size)
	end

	def avg_ctr_new_false(key_1, key_2)
		(key_1.find_all{|k|k if !k.new}.sum(&:ctr) + key_2.find_all{|k|k if !k.new}.sum(&:ctr)) / (key_1.find_all{|k|k if !k.new}.size + key_2.find_all{|k|k if !k.new}.size)
	end

	def avg_ctr_existing_true(key_2)
		(key_2.find_all{|k|k if k.new}.sum(&:ctr)) / (key_2.find_all{|k|k if k.new}.size)
	end

	def avg_ctr_existing_false(key_2)
		(key_2.find_all{|k|k if !k.new}.sum(&:ctr)) / (key_2.find_all{|k|k if !k.new}.size)  
	end

	def overall_avg_CTR_percentage(key_1, key_2)
		ovp = avg_ctr_new_true(key_1, key_2) / overall_avg_ctr(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def new_queries_avg_CTR_percentage(key_1, key_2)
		ovp = avg_ctr_existing_true(key_2) / avg_ctr_new_true(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def existing_queries_avg_CTR_percentage(key_1, key_2)
		ovp = avg_ctr_existing_false(key_2) / avg_ctr_new_false(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	# Average Position
	def overall_avg_position(key_1, key_2)
		(key_1.map(&:avg_position).inject{|sum,x| sum + x } + key_2.map(&:avg_position).inject{|sum,x| sum + x }) / (key_1.map(&:avg_position).size + key_2.map(&:avg_position).size)
	end

	def avg_position_new_true(key_1, key_2)
		(key_1.find_all{|k|k if k.new}.sum(&:avg_position) + key_2.find_all{|k|k if k.new}.sum(&:avg_position)) / (key_1.find_all{|k|k if k.new}.size + key_2.find_all{|k|k if k.new}.size)
	end

	def avg_position_new_false(key_1, key_2)
		(key_1.find_all{|k|k if !k.new}.sum(&:avg_position) + key_2.find_all{|k|k if !k.new}.sum(&:avg_position)) / (key_1.find_all{|k|k if !k.new}.size + key_2.find_all{|k|k if !k.new}.size)
	end

	def avg_positio_existing_true(key_2)
		(key_2.find_all{|k|k if k.new}.sum(&:avg_position)) / (key_2.find_all{|k|k if k.new}.size)
	end

	def avg_positio_existing_false(key_2)
		(key_2.find_all{|k|k if !k.new}.sum(&:avg_position)) / (key_2.find_all{|k|k if !k.new}.size)
	end

	def overall_avg_position_percentage(key_1, key_2)
		ovp = avg_position_new_true(key_1, key_2) / overall_avg_position(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def new_queries_avg_position_percentage(key_1, key_2)
		ovp = avg_positio_existing_true(key_2) / avg_position_new_true(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end

	def existing_queries_avg_position_percentage(key_1, key_2)
		ovp = avg_positio_existing_false(key_2) / avg_position_new_false(key_1, key_2)
		number_to_percentage(ovp, precision: 2)
	end







	def top_ten_on_clicks(key)
		# sums_by_id = []
		keywords = key.group_by(&:query).sort_by{|q, s|s.sum(&:clicks)}.reverse.first(10)
		# keywords.each do |sum|
		# 	sums_by_id << sum[1].map(&:clicks).inject{|sum,x| sum + x}
		# end
	end

	def new_top_ten_on_impressions(key)
		collection_queries_impressions(key, true)
	end

	def past_top_ten_on_impressions(key)
		collection_queries_impressions(key, false)
	end

	def collection_queries_impressions(key, flag)
		# sums_by_id = []
		keywords = if flag
			find_new_query(key)
		else
			find_old_query(key)
		end

		keywords.sort_by{|q, s|s.sum(&:impressions)}.reverse.first(10)
		# keywords.each do |sum|
		# 	sums_by_id << sum[1].map(&:impressions).inject{|sum,x| sum + x}
		# end
	end

	def find_old_query(key)
      key.find_all{|k|k if !k.new}.group_by(&:query)
	end

	def find_new_query(key)
      key.find_all{|k|k if k.new}.group_by(&:query)
	end

	def improved_rankings(key)
		imp_keys = []
		key.group_by(&:query).each do |q|
		  imp_keys << q if q[1].sum(&:impressions) > 100
		end

		keywords = imp_keys.sort_by{|q, s|s.sum(&:avg_position)/s.size}.first(10)
		return keywords
		# keywords.each do |sum|
		# 	if sum[1].size > 100
		# 		sums_by_id << sum[1].size
		# 	end
		# end
		# return sums_by_id
	end

	def lost_rankings(key)
		# sums_by_id = []
		imp_keys = []
		key.group_by(&:query).each do |q|
		  imp_keys << q if q[1].sum(&:impressions) > 100
		end

		keywords = imp_keys.sort_by{|q, s|s.sum(&:avg_position)/s.size}.reverse.first(10)
		return keywords
		# keywords.each do |sum|
		# 	if sum[1].size > 100
		# 		sums_by_id << sum[1].size
		# 	end
		# end
		# return sums_by_id
	end

	# def rankings_sorting(key)
	# 	sums_by_id = []
	# 	keywords = key.group_by(&:query).sort_by{|q, s|s.sum(&:impressions)}.reverse.first(10)
	# 	keywords.each do |sum|
	# 		if sum[1].size > 100
	# 			sums_by_id << sum[1].size
	# 		end
	# 	end
	# 	return sums_by_id
	# end

end
