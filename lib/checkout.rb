class Checkout
  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    total = 0

    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
      if item == :apple || item == :pear
        if (count % 2 == 0)
          total += prices.fetch(item) * (count / 2)
        else
          total += prices.fetch(item) * count
        end
      elsif item == :banana || item == :pineapple
        if item == :pineapple
          total += (prices.fetch(item) / 2)
          total += (prices.fetch(item)) * (count - 1)
        else
          total += (prices.fetch(item) / 2) * count
        end
      # 1st commit
      # buy 3 get 1 free solution for mangos
      # item check in basket if it is mango then count checked. 
      # if it is greater than 3, discount is added by reducing one manago in total price
      
      # 2nd commit
      # code is refactored and discounted mangos count using mode.
      # In every 3 mangos 1 is added free in cart
      elsif item == :mango
        discount_items = count % 3
        if (discount_items >= 0)
          total += prices.fetch(item) * (count - discount_items)
        end
      else
        total += prices.fetch(item) * count
      end
    end

    total
  end

  private

  def basket
    @basket ||= Array.new
  end
end
