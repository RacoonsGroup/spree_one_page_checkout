require 'spec_helper'

describe Spree::Order do

  context 'one page checkout' do
    context 'complete' do
      let(:order) {FactoryGirl.create(:order)}

      it 'should have address, adj and  be complete' do
        order.run_states
        order.adj.should != nil
        order.ship_address != nil
        order.bill_address != nil
        order.state.should eq('complete')
      end

    end
  end
end