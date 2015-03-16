require 'spec_helper'

describe SimplePaginate::ActiveRecordExtension do
  before :all do
    1.upto(100) {|i| User.create name: "user#{'%03d' % i}"}
  end

  after :all do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe '#paginate' do
    subject { User.paginate(page: page) }

    context 'page 1' do
      let(:page) { 1 }

      it { expect(subject.first.name).to eq('user001') }
    end

    context 'page 2' do
      let(:page) { 2 }

      it { expect(subject.first.name).to eq('user026') }
    end

    context 'page < 1' do
      let(:page) { 0 }

      it { expect(subject.first.name).to eq('user001') }
    end

    context 'page > max page' do
      let(:page) { 5 }

      it { expect(subject).to be_empty }
    end
  end  
  
  describe '#page' do
    subject { User.page(page) }

    context 'page 1' do
      let(:page) { 1 }

      it { expect(subject.first.name).to eq('user001') }
    end

    context 'page 2' do
      let(:page) { 2 }

      it { expect(subject.first.name).to eq('user026') }
    end

    context 'page < 1' do
      let(:page) { 0 }

      it { expect(subject.first.name).to eq('user001') }
    end

    context 'page > max page' do
      let(:page) { 5 }

      it { expect(subject).to be_empty }
    end
  end

  describe '#per' do
    context 'page 1 per 5' do
      subject { User.page(1).per(5) }
      it { expect(subject.last.name).to eq('user006') }
    end
  end

  describe '#current_page' do
    context 'page 1' do
      subject { User.paginate(page: 1) }
      it { expect(subject.current_page).to eq 1 }
    end
  end

  describe '#first_page?' do
    context 'on first page' do
      subject { User.paginate(page: 1) }
      it { expect(subject.first_page?).to be_truthy }
    end

    context 'not on first page' do
      subject { User.paginate(page: 2) }
      it { expect(subject.first_page?).to be_falsey }
    end
  end

  describe '#last_page?' do
    context 'on last page' do
      subject { User.paginate(page: 4) }

      it { expect(subject.last_page?).to be_truthy }
    end

    context 'not on last page' do
      subject { User.paginate(page: 3) }
      it { expect(subject.last_page?).to be_falsey }
    end
  end
end
