class User < ApplicationRecord
   validates_presence_of :name, :email
   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties

   def self.all_except(user_id)
      where.not(id: user_id.to_i)
   end

   def hosted_parties
      self.viewing_parties.where("user_parties.host = true")
   end

   def invited_parties
      self.viewing_parties.where.not("user_parties.host = true")
   end
end
