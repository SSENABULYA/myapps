class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  validates :first_name,  presence: true, length: { maximum: 15 }
  validates :last_name,  presence: true, length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #validates :password, presence: true, length: { minimum: 4 }
  #validates :password_confirmation, presence: true
  validates :password, :format => {:with => /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{4,}/, message: "Password must be at least 4 characters and include one number and one letter."}
  
  has_attached_file :avatar, styles: { large: "600x600>" , medium: "300x300>", thumb: "100x100#" }, default_url: "/images/:style/avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_attachment :avatar, :presence => true, :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }, :size => { :in => 0..1.megabytes }
end
