class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :user_id, presence: true
  include SecureRandom

  def self.creates_shorturl(user, long_url)
      short = ShortenedUrl.random_code
      ShortenedUrl.create!(long_url: long_url, short_url: short, user_id: user.id )
  end

  belongs_to :submitter,
            primary_key: :id,
            foreign_key: :user_id,
            class_name: :User

  # def initialize(options)
  #   @long_url = options['long_url']
  #   # @short_url = options['short_url']
  #   @user_id = options['id']
  # end

  def self.random_code
    unique = false
    until unique
      random_code = SecureRandom.urlsafe_base64
      unique = exists?(short_url: random_code)
    end
    random_code
  end


end
