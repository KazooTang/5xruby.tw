# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  iframe      :string(255)
#  summary     :string(255)
#  description :text
#  is_online   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title { Faker::Name.title }
    iframe '<iframe width="100%" src="//www.youtube.com/embed/y9UYG4uP6Ko?rel=0" frameborder="0" allowfullscreen></iframe>'
    summary { Faker::Lorem.paragraph }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
    is_online { rand > 0.5 }
    speakers { Speaker.order('RANDOM()').limit(2) }
    image { Faker::Image.image }
  end
end
