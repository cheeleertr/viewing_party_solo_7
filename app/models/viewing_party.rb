class ViewingParty < ApplicationRecord
   has_many :user_parties
   has_many :users, through: :user_parties

   validate :date_cannot_be_in_the_past,
      :start_time_cannot_be_in_the_past,
      # :start_time_must_be_valid_time
      # :duration_cannot_be_lower_than_runtime

   def find_host
      users.where("user_parties.host = true").first
   end

   def date_cannot_be_in_the_past
      if date.present? && Date.parse(date.to_s) < Date.today
         errors.add(:date, "can't be in the past")
      end
   end

   def start_time_cannot_be_in_the_past
      if date_cannot_be_in_the_past && start_time.present? && start_time < Time.now
         errors.add(:start_time, "can't be in the past")
      end
   end

   def start_time_must_be_valid_time
      if start_time.present? && Time.strptime(start_time)
         errors.add(:start_time, "must be a valid time format")
      end
   end

   # def duration_cannot_be_lower_than_runtime
   #    if duration < runtime
   #       errors.add(:duration, "can't be lower than movie runtime")
   #    end
   # end
end
