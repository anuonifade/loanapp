class MonthlyContribution < ApplicationRecord
  belongs_to :profile

  def self.to_csv
    attributes = %w{amount month year profile_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |contribution|
        csv << attributes.map{ |attr| contribution.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
  end
end
