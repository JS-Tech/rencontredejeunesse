class BundleValidator < ActiveModel::Validator

    VALIDATIONS = {
      regular: [:uniqueness_of_bundle, :name_of_order_type, :availability_of_bundle],
      event: [:presence_of_bundle, :uniqueness_of_bundle, :name_of_order_type, :availability_of_bundle, :limit_in_bundle]
    }

    def validate(record)
      @record = record
      @order_items = record.order_items
      @item_ids = @order_items.map(&:item_id)
      @bundle_ids = bundle_ids
      @bundle = bundle
      if @item_ids.size != 0
        VALIDATIONS[@record.order_type].each do |v|
          send(v)
        end
      end
    end

    private

    def presence_of_bundle
      if @bundle_ids.include?(nil)
        @record.errors.add(:base, "Un article n'est pas dans un bundle.")
      end
    end

    def uniqueness_of_bundle
      if @bundle_ids.length > 1
        @record.errors.add(:base, "Les articles ne font pas partie du même bundle.")
      end
    end

    # requires uniqueness of bundle
    def name_of_order_type
      if @bundle_ids.any? && @bundle.order_type != @record.order_type.to_s
        @record.errors.add(:base, "Un article n'est pas compatible.")
      end
    end

    # requires uniqueness of bundle
    def availability_of_bundle
      if @bundle && !@bundle.open && !@record.limited
        @record.errors.add(:base, "Les articles ne sont pas disponibles.")
      end
    end

    # requires uniqueness of bundle
    def limit_in_bundle
      sum = @order_items.inject(0) { |sum, i| sum + i.quantity }
      if @bundle && @bundle.limit && sum > @bundle.limit
        @record.errors.add(:base, "Il ne doit pas y avoir plus de #{@bundle.limit} article(s).")
      end
    end

    def bundle_ids
      Item.where(id: @item_ids).pluck(:order_bundle_id).uniq
    end

    def bundle
      OrderBundle.find_by(id: @bundle_ids[0])
    end

end