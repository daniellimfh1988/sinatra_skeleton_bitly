class User < ActiveRecord::Base
  has_many :urls

def self.authenticate(email, password) #3
    @user = User.find_by_email(email)
    return false if @user.nil?
    if @user.password == password
      return @user
    else
      return false
    end
  end
end
