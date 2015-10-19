module ApplicationHelper

	def overall_tnk(key)
		key.size
	end

	def new_queries_tnk(key)
		key.find_all{|k|k if k.new}.size
	end

	def existing_queries_tnk(key)
		key.find_all{|k|k if !k.new}.size
	end

	def overall_visbl(key)
		key.sum(:impressions)
		# key.map(&:impressions).inject{|sum,x| sum + x }
	end

	def new_queries_visbl(key)
		key.find_all{|k|k if k.new}.map(&:impressions).inject{|sum,x| sum + x }
	end

	def existing_queries_visbl(key)
		key.find_all{|k|k if !k.new}.map(&:impressions).inject{|sum,x| sum + x }
	end

	def overall_traffic(key)

		key.map(&:clicks).inject{|sum,x| sum + x }
	end

	def new_queries_traffic(key)
		key.find_all{|k|k if k.new}.map(&:clicks).inject{|sum,x| sum + x }
	end

	def existing_queries_traffic(key)
		key.find_all{|k|k if !k.new}.map(&:clicks).inject{|sum,x| sum + x }
	end

	def overall_avg_ctr(key)
		sum = (key.map(&:ctr).inject{|sum,x| sum + x }).to_f / (key.map(&:ctr).size)
		number_to_percentage(sum, precision: 2)
	end

	def new_queries_avg_ctr(key)
		sum = (key.find_all{|k|k if k.new}.map(&:ctr).inject{|sum,x| sum + x }).to_f / (key.find_all{|k|k if k.new}.size)
		number_to_percentage(sum, precision: 2)
	end

	def existing_queries_avg_ctr(key)
		sum = (key.find_all{|k|k if !k.new}.map(&:ctr).inject{|sum,x| sum + x }).to_f / (key.find_all{|k|k if !k.new}.size)
		number_to_percentage(sum, precision: 2)
	end

	def overall_avg_position(key)
		sum = (key.map(&:avg_position).inject{|sum,x| sum + x }).to_f / (key.size)
		number_to_percentage(sum, precision: 2)
	end

	def new_queries_avg_position(key)
		sum = (key.find_all{|k|k if k.new}.map(&:avg_position).inject{|sum,x| sum + x }).to_f / (key.find_all{|k|k if k.new}.size)
		number_to_percentage(sum, precision: 2)
	end

	def existing_queries_avg_position(key)
		sum = (key.find_all{|k|k if !k.new}.map(&:avg_position).inject{|sum,x| sum + x }).to_f / (key.find_all{|k|k if !k.new}.size)
	    number_to_percentage(sum, precision: 2)
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
