class User < ApplicationRecord
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :books, dependent: :destroy
         has_one_attached :profile_image
         
         validates :name, presence: true, uniqueness: true, length: { in: 2..20 }

         def get_profile_image(image_width = 100, image_height = 100)
           unless profile_image.attached?
             file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
             profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
           end
           profile_image.variant(resize_to_limit: [100, 100]).processed
         end

         def introduction
           self[:introduction]
         end
end
