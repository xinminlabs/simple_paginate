require 'spec_helper'

describe 'SimplePaginate::ActionViewExtension', type: :helper, if: defined?(Rails) do
  before :all do
    1.upto(100) {|i| User.create name: "user#{'%03d' % i}"}
  end

  after :all do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe '#link_to_previous_page' do
    subject { helper.link_to_previous_page users, 'Previous Page', { controller: 'users', action: 'index' } }

    context 'having previous pages' do
      let(:users) { User.paginate(page: 3) }

      it { expect(subject).to eq('<a href="/users?page=2">Previous Page</a>') }
    end

    context 'the first page' do
      let(:users) { User.paginate(page: 1) }

      it { expect(subject).to eq('<a disabled="disabled" href="#">Previous Page</a>') }
    end
  end

  describe '#link_to_next_page' do
    subject { helper.link_to_next_page users, 'Next Page', { controller: 'users', action: 'index' } }

    context 'having next pages' do
      let(:users) { User.paginate(page: 3) }

      it { expect(subject).to eq('<a href="/users?page=4">Next Page</a>') }
    end

    context 'the last page' do
      let(:users) { User.paginate(page: 4) }

      it { expect(subject).to eq('<a disabled="disabled" href="#">Next Page</a>') }
    end
  end
end
