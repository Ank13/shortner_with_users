
class User < ActiveRecord::Base
  has_many :urls
  include BCrypt

  def self.create_user(name, email, password)
    User.create(name: name, email: email, password: BCrypt::Password.create(password))
  end

  def self.authenticate?(entered_password, email)
    if User.find_by_email(email).nil?
      return nil
    else  
      user = User.find_by_email(email) 
    end 
    BCrypt::Password.new(user.password) == entered_password
  end

end
