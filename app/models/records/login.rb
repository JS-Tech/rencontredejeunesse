module Records

  class Login < Record
    FEE = 5
    ENTRY_PRICE = 20

    self.table_name = 'records_login'

    validates :entries, numericality: { only_integer: true, greater_than: 0 }
    validates :group, length: { maximum: 70 }

    def calculate_amount
      return (entries * ENTRY_PRICE + FEE) * 100
    end

  end

end