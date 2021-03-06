class Discount < ApplicationRecord

  has_many :orders, dependent: :restrict_with_exception
  has_and_belongs_to_many :items

  enum category: [:money, :percent, :free]

  validates :code, uniqueness: true
  validates :category, presence: true, inclusion: { in: categories.keys }
  validates :reduction, presence: true, numericality: { greater_than_or_equal_to: 500 }, if: :money?
  validates :reduction, presence: true, numericality: { greater_than: 0, less_than: 100 }, if: :percent?
  validates :number, presence: true, numericality: { greater_than: 0 }, if: :free?
  validates :items, presence: true, if: :free?

  before_create :generate_code

  # Money: a fixed amount
  # Percent: a percentage applied to 1. the amount of order 2. a list of items
  # Free: free item(s) limited by #number 
  def calculate_discount(order)
    @item_ids = self.item_ids
    @order_items = order.order_items.select { |i| !i.marked_for_destruction? }
    if self.money? 
      return self.reduction
    elsif self.percent? && item_ids.empty?
      return order.amount * self.reduction / 100
    else
      return send("calculate_#{category}")
    end
  end

  def calculate_percent
    @order_items.inject(0) do |sum, order_item|
      if order_item.item_id.in?(@item_ids) 
        sum + (order_item.item.price * order_item.quantity * self.reduction / 100)
      else
        sum
      end
    end
  end

  def calculate_free
    count = self.number 
    @order_items.inject(0) do |sum, order_item|
      if count != 0 && order_item.item_id.in?(@item_ids)
        factor = [order_item.quantity, count].min
        count -= factor
        sum + order_item.item.price * factor
      else
        sum
      end
    end
  end

  private

  def generate_code
    loop do
      self.code = SecureRandom.hex(4).upcase
      break unless Discount.where(code: self.code).exists?
    end
  end

end
