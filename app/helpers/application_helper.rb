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
		key.map(&:impressions).inject{|sum,x| sum + x }
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
		sum = (key.map(&:ctr).inject{|sum,x| sum + x }) / (key.map(&:ctr).size)
		number_to_percentage(sum, precision: 2)
	end

	def new_queries_avg_ctr(key)
		sum = (key.find_all{|k|k if k.new}.map(&:ctr).inject{|sum,x| sum + x }) / (key.find_all{|k|k if k.new}.size)
		number_to_percentage(sum, precision: 2)
	end

	def existing_queries_avg_ctr(key)
		sum = (key.find_all{|k|k if !k.new}.map(&:ctr).inject{|sum,x| sum + x }) / (key.find_all{|k|k if !k.new}.size)
		number_to_percentage(sum, precision: 2)
	end

	def overall_avg_position(key)
		key.map(&:avg_position).inject{|sum,x| sum + x }
	end

	def new_queries_avg_position(key)
		key.find_all{|k|k if k.new}.map(&:avg_position).inject{|sum,x| sum + x }
	end

	def existing_queries_avg_position(key)
		key.find_all{|k|k if !k.new}.map(&:avg_position).inject{|sum,x| sum + x }
	end

end
