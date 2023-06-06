class User
  include Mongoid::Document
  # include Mongoid::Timestamps
  include ActiveModel::SecurePassword # encryption

  field :username, type: String
  field :email, type: String
  field :password_digest, type: String

  # for validation
  validates :username, uniqueness: { message: "Username has already been taken." }, presence: true
  validates :email, uniqueness: { message: "Email has already been taken." }, presence: true
  validates :password, presence: true, :length => {:minimum => 9}, :on => :create

  # encryption
  has_secure_password 

  def successful_response
    {
      id: id.to_s,
      username: username,
      email: email,
    }
  end

end
