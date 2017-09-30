class User < ApplicationRecord
  before_save {email.downcase!}
  validates :name,presence:true,length:{maximum: 50}
  #VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\Z/i  original regx
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\Z/i  # I changed it to reject the invalid address like "foo@cuc..edu.cn"
  validates :email,presence:true,length:{maximum:255},
                    format: {with:VALID_EMAIL_REGEX},
                    uniqueness:{case_sensitive:false}
  has_secure_password
  validates :password,length:{minimum:6},presence:true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string,cost: cost)
  end                            
end
