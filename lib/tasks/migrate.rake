namespace :migrate do
  
  # After the migration is successful, drop the order_types table and remove the order_type_id from order_bundles.
  # DOES NOT WORK ANYMORE SINCE THE DATABASE HAS CHANGED
  desc "Migrate the order_type association to an enum on order_bundle"
  task order_types: :environment do
    OrderBundle.all.each do |b|
      order_type = OrderType.find(b.order_type_id)
      case order_type.name
      when "volunteer"
        order_type = "event"
        bundle_type = "volunteer"
      when "stands"
        order_type = "event"
        bundle_type = "stand"
      when "event"
        order_type = "event"
      when "regular"
        order_type = "regular"
      end
      puts "Bundle #{b.name} set with order type `#{order_type}` and bundle type `#{bundle_type}`"
      b.update_attributes(order_type: order_type, bundle_type: bundle_type)
    end
    OrderType.all.each do |t|
      if t.form.present?
        t.order_bundles.each do |b|
          puts "Bundle #{b.name} set with form `#{t.form.name}`"
          b.update_attributes(form: t.form)
        end
      end
    end
  end

end