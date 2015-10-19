class Keyword < ActiveRecord::Base
  def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1).map!(&:downcase)
		header.map! { |element|
	    if(element == "avg. position")
	      "avg_position"
	    else
	      element
	    end
		}
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			keyword = Keyword.new
			keyword.attributes = row.to_hash.slice(*row.to_hash.keys)
			keyword.save!
		end
  end

  def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
		  when ".csv" then Roo::CSV.new(file.path)
		  when ".xls" then Roo::Excel.new(file.path)
		  when ".xlsx" then Roo::Excelx.new(file.path)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
  end

 #  def self.search_first_period(search)
 #  	searchfrom_1 = search["from_1"]
 #    searchto_1 = search["to_1"]
	#   where('date between ? and ?', searchfrom_1.to_date, searchto_1.to_date)
	# end

  def self.search_keywords_period(params_date)
    dates = params_date.split(" - ")
  	date_1 = dates[0]
    date_2 = dates[1]
	  where('date between ? and ?', date_1.to_date, date_2.to_date)
  end

end