module ApplicationHelper

	def collect_datas(array)
		imp = top_keyword(array, "impressions")
		clicks = top_keyword(array, "clicks")
		ctr = top_keyword(array, "ctr")
		avg_position = top_keyword(array, "avg_position")

		[imp, clicks, ctr, avg_position]
	end

	def s_collect_datas(name, array2)
		imp = second_period(name, array2, "impressions")
		clicks = second_period(name, array2, "clicks")
		ctr = second_period(name, array2, "ctr")
		avg_position = second_period(name, array2, "avg_position")

		[imp, clicks, ctr, avg_position]
	end

	def top_keyword(array, field)
		eval("array.map(&:#{field}).sum")
	end

	def second_period(name, keys, field)
		sec_keys = keys.find_all{|k|k if k.query.eql?(name)}
		top_keyword(sec_keys, field)
	end

	def compare_result(current, sec_period)
		current = 1 if current.eql?(0)
		ovp = sec_period/current.to_f
		number_to_percentage(ovp*100, precision: 2)
	end

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
		(key_1.map(&:impressions).inject{|sum,x| sum + x }).to_i + (key_2.map(&:impressions).inject{|sum,x| sum + x }).to_i
	end

	def visibility_new_true(key_1, key_2)
		(key_1.find_all{|k|k if k.new}.sum(&:impressions)).to_i + (key_2.find_all{|k|k if k.new}.sum(&:impressions)).to_i
	end

	def visibility_new_false(key_1, key_2)
		(key_1.find_all{|k|k if !k.new}.sum(&:impressions)).to_i + (key_2.find_all{|k|k if !k.new}.sum(&:impressions)).to_i
	end

	def visibility_existing_true(key_2)
		key_2.find_all{|k|k if k.new}.sum(&:impressions)
	end

	def visibility_existing_false(key_2)
		key_2.find_all{|k|k if !k.new}.sum(&:impressions)
	end

	def overall_visibility_percentage(key_1, key_2)
		ovp = 0
		ovp = visibility_new_true(key_1, key_2) / overall_visbl(key_1, key_2).to_f if !overall_visbl(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	def new_queries_visibility_percentage(key_1, key_2)
		ovp = 0
		ovp = visibility_existing_true(key_2) / visibility_new_true(key_1, key_2).to_f if !visibility_new_true(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	def existing_queries_percentage(key_1, key_2)
		ovp = 0
		ovp = visibility_existing_false(key_2) / visibility_new_false(key_1, key_2).to_f if !visibility_new_false(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	# Traffic #
	def overall_traffic(key_1, key_2)
		key_1.map(&:clicks).inject{|sum,x| sum + x }.to_i + key_2.map(&:clicks).inject{|sum,x| sum + x }.to_i
	end

	def traffic_new_true(key_1, key_2)
		key_1.find_all{|k|k if k.new}.sum(&:clicks).to_i + key_2.find_all{|k|k if k.new}.sum(&:clicks).to_i
	end

	def traffic_new_false(key_1, key_2)
		key_1.find_all{|k|k if !k.new}.sum(&:clicks).to_i + key_2.find_all{|k|k if !k.new}.sum(&:clicks).to_i
	end

	def traffic_existing_true(key_2)
		key_2.find_all{|k|k if k.new}.sum(&:clicks)
	end

	def traffic_existing_false(key_2)
		key_2.find_all{|k|k if !k.new}.sum(&:clicks)
	end

	def overall_traffic_percentage(key_1, key_2)
		ovp = 0
		ovp = traffic_new_true(key_1, key_2) / overall_traffic(key_1, key_2).to_f if !overall_traffic(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	def new_queries_traffic_percentage(key_1, key_2)
		ovp = 0
		ovp = traffic_existing_true(key_2) / traffic_new_true(key_1, key_2).to_f if !traffic_new_true(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	def existing_queries_traffic_percentage(key_1, key_2)
		ovp = 0
		ovp = traffic_existing_false(key_2) / traffic_new_false(key_1, key_2).to_f if !traffic_new_false(key_1, key_2).eql?(0)
		number_to_percentage(ovp*100, precision: 2)
	end

	# Average CTR #
	def overall_avg_ctr(key_1, key_2)
		devided = (key_1.map(&:ctr).size + key_2.map(&:ctr).size)
		return 0 if devided.eql?(0)
		(key_1.map(&:ctr).inject{|sum,x| sum + x }.to_i + key_2.map(&:ctr).inject{|sum,x| sum + x }.to_i) / (key_1.map(&:ctr).size + key_2.map(&:ctr).size).to_f
	end

	def avg_ctr_new_true(key_1, key_2)
		devided = (key_1.find_all{|k|k if k.new}.size + key_2.find_all{|k|k if k.new}.size)
		return 0 if devided.eql?(0)
		(key_1.find_all{|k|k if k.new}.sum(&:ctr).to_f + key_2.find_all{|k|k if k.new}.sum(&:ctr)).to_f / (key_1.find_all{|k|k if k.new}.size + key_2.find_all{|k|k if k.new}.size).to_f
	end

	def avg_ctr_new_false(key_1, key_2)
		devided = (key_1.find_all{|k|k if !k.new}.size + key_2.find_all{|k|k if !k.new}.size)
		return 0 if devided.eql?(0)
		(key_1.find_all{|k|k if !k.new}.sum(&:ctr).to_i + key_2.find_all{|k|k if !k.new}.sum(&:ctr)).to_f / (key_1.find_all{|k|k if !k.new}.size + key_2.find_all{|k|k if !k.new}.size).to_f
	end

	def avg_ctr_existing_true(key_2)
		devided = key_2.find_all{|k|k if k.new}.size
		return 0 if devided.eql?(0)
		(key_2.find_all{|k|k if k.new}.sum(&:ctr)) / (key_2.find_all{|k|k if k.new}.size).to_f
	end

	def avg_ctr_existing_false(key_2)
		devided = (key_2.find_all{|k|k if !k.new}.size)  
		return 0 if devided.eql?(0)
		(key_2.find_all{|k|k if !k.new}.sum(&:ctr)) / (key_2.find_all{|k|k if !k.new}.size).to_f  
	end

	def overall_avg_CTR_percentage(key_1, key_2)
		devided = overall_avg_ctr(key_1, key_2) 
		return 0.0 if devided.eql?(0)
		ovp = avg_ctr_new_true(key_1, key_2) / overall_avg_ctr(key_1, key_2).to_f
		number_to_percentage(ovp*100, precision: 2)
	end

	def new_queries_avg_CTR_percentage(key_1, key_2)
		devided = avg_ctr_new_true(key_1, key_2)
		return 0.0 if devided.eql?(0)
		ovp = avg_ctr_existing_true(key_2) / avg_ctr_new_true(key_1, key_2).to_f
		number_to_percentage(ovp*100, precision: 2)
	end

	def existing_queries_avg_CTR_percentage(key_1, key_2)
		devided = avg_ctr_new_false(key_1, key_2)
		return 0.0 if devided.eql?(0)
		ovp = avg_ctr_existing_false(key_2) / avg_ctr_new_false(key_1, key_2).to_f
		number_to_percentage(ovp*100, precision: 2)
	end

	# Average Position
	def overall_avg_position(key_1, key_2)
		devided = (key_1.map(&:avg_position).size + key_2.map(&:avg_position).size)
		return 0 if devided.eql?(0)
		(key_1.map(&:avg_position).inject{|sum,x| sum + x }.to_i + key_2.map(&:avg_position).inject{|sum,x| sum + x }.to_i) / devided.to_f
	end

	def avg_position_new_true(key_1, key_2)
		devided = (key_1.find_all{|k|k if k.new}.size + key_2.find_all{|k|k if k.new}.size)
		return 0 if devided.eql?(0)
		(key_1.find_all{|k|k if k.new}.sum(&:avg_position) + key_2.find_all{|k|k if k.new}.sum(&:avg_position)) / devided.to_f
	end

	def avg_position_new_false(key_1, key_2)
		devided = (key_1.find_all{|k|k if !k.new}.size + key_2.find_all{|k|k if !k.new}.size)
		return 0 if devided.eql?(0)
		(key_1.find_all{|k|k if !k.new}.sum(&:avg_position) + key_2.find_all{|k|k if !k.new}.sum(&:avg_position)) / devided.to_f
	end

	def avg_positio_existing_true(key_2)
		devided = (key_2.find_all{|k|k if k.new}.size)
		return 0 if devided.eql?(0)
		(key_2.find_all{|k|k if k.new}.sum(&:avg_position)) / devided.to_f
	end

	def avg_positio_existing_false(key_2)
		devided = (key_2.find_all{|k|k if !k.new}.size)
		return 0 if devided.eql?(0)
		(key_2.find_all{|k|k if !k.new}.sum(&:avg_position)) / devided.to_f
	end

	def overall_avg_position_percentage(key_1, key_2)
		devided = overall_avg_position(key_1, key_2)
		return 0.0 if devided.eql?(0)
		ovp = avg_position_new_true(key_1, key_2) / devided.to_f
		number_to_percentage(ovp*100, precision: 2)
	end

	def new_queries_avg_position_percentage(key_1, key_2)
		devided = avg_position_new_true(key_1, key_2)
		return 0.0 if devided.eql?(0)
		ovp = avg_positio_existing_true(key_2) / avg_position_new_true(key_1, key_2).to_f
		number_to_percentage(ovp*100, precision: 2)
	end

	def existing_queries_avg_position_percentage(key_1, key_2)
		devided = avg_position_new_false(key_1, key_2)
		return 0.0 if devided.eql?(0)
		ovp = avg_positio_existing_false(key_2) / avg_position_new_false(key_1, key_2).to_f
		number_to_percentage(ovp*100, precision: 2)
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
		  imp_keys << q if q[1].sum(&:impressions) > 10
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
		  imp_keys << q if q[1].sum(&:impressions) > 10
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

	def ctr_group(keys)
		imp_keys = []
		keys.group_by(&:query).each do |q|
		  imp_keys << q if q[1].sum(&:impressions) > 10
		end

		keywords = imp_keys.sort_by{|q, s|s.sum(&:ctr)/s.size}.reverse
		return keywords
	end

	def build_chart_datas(keywords)
		keywords = keywords.group_by(&:avg_position)
		blue, yellow, green, gray, l_gray = [], [], [], [], []
		keywords.each do |k|
			if k[0] > 20
				l_gray << k[1].size
			elsif k[0] < 21 && k[0] > 9.9
				gray << k[1].size
			elsif k[0] < 11 && k[0] > 4.9
				green << k[1].size
			elsif k[0] < 5 && k[0] > 2.9
				yellow << k[1].size
			else	
				blue << k[1].size
			end
		end

		[blue, yellow, green, gray, l_gray]
	end

	def chart_structure(keywords, keywords2)
	   blue, yellow, green, gray, l_gray = build_chart_datas(keywords)
	   s_blue, s_yellow, s_green, s_gray, s_l_gray = build_chart_datas(keywords2)
	   first_period = keywords.first.date.strftime('%D')
	   second_period = keywords2.first.date.strftime('%D')

	   blue_text = "{        
       type: 'stackedColumn',       
       showInLegend:true,
       color: '#096AE8',
       name:'1-2',
       dataPoints: [
       {  y: #{blue.sum}, label: '#{first_period}'},
       {  y: #{s_blue.sum}, label: '#{second_period}'}
       ]
       },"
       yellow_text = "{        
       type: 'stackedColumn',       
       showInLegend:true,
       color: '#C28F02',
       name:'3-4',
       dataPoints: [
       {  y: #{yellow.sum}, label: '#{first_period}'},
       {  y: #{s_yellow.sum}, label: '#{second_period}'}
       ]
       },"
       green_text = "{        
       type: 'stackedColumn',       
       showInLegend:true,
       color: '#107502',
       name:'5-10',
       dataPoints: [
       {  y: #{green.sum}, label: '#{first_period}'},
       {  y: #{s_green.sum}, label: '#{second_period}'}
       ]
       },"
       grey_text = "{        
       type: 'stackedColumn',       
       showInLegend:true,
       color: '#949699',
       name:'11-20',
       dataPoints: [
       {  y: #{gray.sum}, label: '#{first_period}'},
       {  y: #{s_gray.sum}, label: '#{second_period}'}
       ]
       },"
       l_grey_text = "{        
       type: 'stackedColumn',       
       showInLegend:true,
       color: '#C0C2C4',
       name:'>20',
       dataPoints: [
       {  y: #{l_gray.sum}, label: '#{first_period}'},
       {  y: #{s_l_gray.sum}, label: '#{second_period}'}
       ]
       }"

       interval = 8
       interval = 100 if (blue+yellow+green+gray+l_gray).sum > 100 || (s_blue+s_yellow+s_green+s_gray+s_l_gray).sum > 100
       ["["+blue_text+yellow_text+green_text+grey_text+l_grey_text+"]", interval]
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
