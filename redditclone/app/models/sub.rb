class Sub < ApplicationRecord

    validates :title, presense: true, uniqueness: true
    validates :moderator_id, presense: true

    has_many :posts,
    foreign_key: :sub_id,
    class_name: :Post
end