require 'spec_helper'

module Refinery
  module Covers
    describe Cover do
      describe "validations" do
        subject do
          FactoryGirl.create(:cover)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
