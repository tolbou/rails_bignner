class User < ApplicationRecord
    # validates :name, :address, presence: true
    # # 整数のみ、０以上
    # validates :age, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    # # 電話番号フォーマットに従って
    # validates :tel, presence: true, format:{ with: /\A\d{10}$|^\d{11}\z/ }

    validates :name, presence: true
    validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

end
