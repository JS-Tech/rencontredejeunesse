Given("I am a volunteer") do
  @user = create(:option_order)
end

Given("a volunteering is available") do
  @order_bundle = create(:order_bundle_with_items, key: "volunteers-rj-19")
end
