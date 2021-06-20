class Address < ApplicationRecord
    belongs_to :customer
    
    def address_infomation
        [postal_code, address, name].join(' ')
    end
    
end
