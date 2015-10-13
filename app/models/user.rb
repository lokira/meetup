class User < ActiveRecord::Base

  validates_uniqueness_of :name
  def self.hash_password password
    Digest::SHA1.hexdigest("salt#{Digest::SHA1.hexdigest(password)}")
  end
end
