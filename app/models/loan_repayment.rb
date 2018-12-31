class LoanRepayment < ApplicationRecord
  belongs_to :loan

  def self.to_csv
    attributes = %w{amount month year profile_id}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |loan|
        csv << attributes.map { |attr| loan.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      LoanRepayment.create! row.to_hash
    end
  end
end
