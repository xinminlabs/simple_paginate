require 'spec_helper'

describe SimplePaginate::Configuration do
  subject { SimplePaginate.config }

  describe 'default_per_page' do
    context 'by default' do
      it { expect(subject.default_per_page).to eq 25 }
    end

    context 'configured via config block' do
      before do
        SimplePaginate.configure do |config|
          config.default_per_page = 20
        end
      end

      it { expect(subject.default_per_page).to eq 25 }

      before do
        SimplePaginate.configure do |config|
          config.default_per_page = 25
        end
      end
    end
  end
end
