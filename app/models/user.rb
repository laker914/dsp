require 'digest/sha1'
class User < ActiveRecord::Base
  validates_presence_of :login , :scope => :email ,:message => I18n.t(:message_exist_email)
  
  attr_accessor :password_confirmation
  attr_accessor :password
  attr_accessor :old_password
  
  validates_confirmation_of :pasword , :allow_nil => true
  
  def self.authenticate(login , password)
      user = where(" login = ?" ,login).first
      if user 
          expected_password = encrypted_password(password , user.salt)
          puts expected_password
          puts user.hashed_password
          if user.hashed_password != expected_password
               user = nil
          end
      end
      user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
     create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def active?
    true
  end
  
  def registered?
    false
  end
  
  def locked?
    false
  end
  
  private 
  def self.encrypted_password(password , salt)
     string_to_hash = password + "DSP" + salt
     Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
     self.salt = self.object_id.to_s + rand.to_s
  end
end
