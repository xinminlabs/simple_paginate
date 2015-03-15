require 'spec_helper'
include SimplePaginate::Helpers

describe 'SimplePaginate::Helpers', type: :helper do
  describe 'Tag' do
    describe '#page_url_for' do
      before { helper.request.assign_parameters(_routes, 'users', 'index') }

      context 'for first page' do
        subject { Tag.new(helper).page_url_for(1) }
        it { expect(subject).to eq('/users') }
      end

      context 'with a friendly route setting' do
        before do
          helper.request.assign_parameters(_routes, 'users', 'index', page: 3)
        end

        context 'for first page' do
          subject { Tag.new(helper).page_url_for(1) }
          it { expect(subject).to eq('/users') }
        end

        context 'for other page' do
          subject { Tag.new(helper).page_url_for(5) }
          it { expect(subject).to eq('/users?page=5') }
        end
      end
    end
  end

  describe 'Paginator' do
    describe 'Paginator::PageProxy' do
      describe '#first?' do
        context 'page == 1' do
          subject { Paginator::PageProxy.new(current_page: 1, length: 20, per_page: 25) }
          it { expect(subject.first?).to be_truthy }
        end
        context 'page != 1' do
          subject { Paginator::PageProxy.new(current_page: 5, length: 20, per_page: 25) }
          it { expect(subject.first?).to be_falsey }
        end
      end

      describe '#last?' do
        context 'length == per_page' do
          subject { Paginator::PageProxy.new(current_page: 5, length: 25, per_page: 25) }
          it { expect(subject.last?).to be_falsey}
        end
        context 'length < per_page' do
          subject { Paginator::PageProxy.new(current_page: 5, length: 20, per_page: 25) }
          it { expect(subject.last?).to be_truthy }
        end
      end
    end
  end
end
