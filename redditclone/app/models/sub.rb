class Sub < ApplicationRecord

    validates :title, presense: true, uniqueness: true
    validates :moderator_id, presense: true

    
end