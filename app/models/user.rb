class User
  include Mongoid::Document
  # include Mongoid::Timestamps
  include ActiveModel::SecurePassword # encryption

  field :username, type: String
  field :email, type: String
  field :password_digest, type: String

  # for validation
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, :length => {:minimum => 9}, :on => :create

  has_secure_password # encryption

end
  