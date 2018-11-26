require 'csv'

# class for saving some useful info into csv file
class FileCSV
  def save_info(data, filename)
    File.open(filename, 'w') { |f| f.write(prepared_info(data)) }
  end

  def prepared_info(data)
    data.inject([]) { |csv, row| csv << CSV.generate_line(row) }.join('')
  end
end
