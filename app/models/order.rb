class Order < ApplicationRecord
    enum payment_method: {
    クレジットカード: 0,
    銀行振込: 1
  }
  
     enum status: {
    入金待ち: 0,
    入金確認: 1,
    発送準備中: 2,
    発送済み: 3
  }
  
  belongs_to :customer
  has_many :order_details
  
end
