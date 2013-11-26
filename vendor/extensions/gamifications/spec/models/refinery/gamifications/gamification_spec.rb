require 'spec_helper'

module Refinery
  module Gamifications
    describe Gamification do
      describe "validations" do
        subject do
          FactoryGirl.create(:gamification)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
