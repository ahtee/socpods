class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email 
    before_save :downcase_username
    before_create :create_activation_digest
    #validates :name, length: { maximum: 50 } # removed this in initial signup form
    VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
    validates :username, presence: true, length: { minimum: 5, maximum: 20 },
              format: { with: VALID_USERNAME_REGEX },
              uniqueness: { case_sensitive: false }
    validates :is_signed_in, inclusion: [true, false]
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100}, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

    def to_param
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
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end

    def activate
        update_columns(activated: FILL_IN, activated_at: FILL_IN)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
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

    private 

        def downcase_email
            self.email = email.downcase
        end

        def downcase_username
            self.username = username.downcase
        end

        def create_activation_digest
            self.activation_token  = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
