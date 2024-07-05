class ViewingParty < ApplicationRecord
   validates_presence_of :date,
                        :start_time

   has_many :user_parties
   has_many :users, through: :user_parties

   validate :date_cannot_be_in_the_past,
      :start_time_cannot_be_in_the_past,

   def find_host
      users.where("user_parties.host = true").first
   end

   def date_cannot_be_in_the_past
      if date.present? && Date.parse(date.to_s) < Date.today
         errors.add(:date, "can't be in the past")
      end
   end

   def start_time_cannot_be_in_the_past
      if start_time.present? && start_time < Time.now
         # date_cannot_be_in_the_past && 
         
         errors.add(:start_time, "can't be in the past")
      end
   end
end
