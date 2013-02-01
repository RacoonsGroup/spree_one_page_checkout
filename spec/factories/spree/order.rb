FactoryGirl.define do
  factory :order do
    state 'cart'
    line_items { |p| p.association(:line_item) }
  end
end