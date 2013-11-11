require 'spec_helper'

describe Spree::Order do

  context 'one page checkout' do
    context 'complete' do
      let(:order) do
        order = stub_model(Spree::Order)
        product = stub_model(Spree::Product, :name => %Q{The "BEST" product})
        variant = stub_model(Spree::Variant, :product => product)
        price = stub_model(Spree::Price, :variant => variant)
        line_item = stub_model(Spree::LineItem, :variant => variant, :order => order, :quantity => 1, :price => 5)
        variant.stub(:default_price => price)
        order.stub(:line_items => [line_item])
        order
      end
      let(:variant) {create(:variant)}
      let(:ship_address) {create(:address)}
      let(:bill_address) {create(:address)}
      let(:shipping_method){ FactoryGirl.create(:shipping_method) }

      before do
        order.bill_address = bill_address
        order.ship_address = ship_address
        order.shipping_method_id = shipping_method.id
      end

      it 'should have address, adj and  be complete' do
        puts order.line_items.inspect
        order.run_states
        order.adj.should != nil
        order.ship_address != nil
        order.bill_address != nil
        order.state.should eq('complete')
      end

    end
  end
end