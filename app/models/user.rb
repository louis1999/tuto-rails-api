class User < ApplicationRecord


    validates_uniqueness_of :email
    validates_uniqueness_of :username

    validates_presence_of :email, :username, :password_digest


    # gem bcrypt
    has_secure_password 

end
