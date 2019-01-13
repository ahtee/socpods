class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    attr_accessor :remember_token
    before_save { email.downcase! } 
    before_save { username.downcase! }
    #validates :name, length: { maximum: 50 } # removed this in initial signup form
    VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
    validates :username, presence: true, length: { minimum: 4, maximum: 20 },
              format: { with: VALID_USERNAME_REGEX },
              uniqueness: { case_sensitive: false }
    validates :is_signed_in, inclusion: [true, false]
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100}, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    def to_param #change url from user/:id to just /username
        username
      end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    class << self
        # Returns the hash digest of the given string.
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
  
      # Returns a random token.
        def new_token
            SecureRandom.urlsafe_base64
        end
    end
end
