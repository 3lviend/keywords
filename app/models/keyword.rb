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

  def self.search(search)
  	searchfrom = search["from"]
    searchto = search["to"]
	  where('date between ? and ?', searchfrom.to_date, searchto.to_date)
	end

end