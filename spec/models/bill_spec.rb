require 'rails_helper'

RSpec.describe Bill do
  describe '#update_next_due_date' do
    context 'when the bill is non-recurring' do
      let(:bill) { Bill.new(repeat_interval: RepeatInterval.new(interval: 'one_time')) }

      it 'returns nil' do
        expect(bill.update_next_due_date).to be_nil
      end
    end

    context 'when the bill is recurring' do
      let(:original_date) { Time.zone.now }
      let(:bill) { create :bill, next_due_date: original_date }
      let(:expected_due_date) { original_date + 2.months }

      it 'returns the next date based on the repeat interval' do
        expect(bill.update_next_due_date).to be_truthy
        expect(bill.reload.next_due_date.strftime("%m/%d/%Y")).to eql(expected_due_date.strftime("%m/%d/%Y"))
      end
    end
  end

  describe '#next_due_date' do
    context 'when the passed in value is a ActiveSupport::TimeWithZone obj' do
      let(:date) { Time.zone.now }
      let(:bill) { Bill.new }

      it 'assigns the value to the next_due_date attribute' do
        bill.next_due_date = date
        expect(bill.next_due_date).to eql(date)
      end
    end

    context 'when the passed in value is a valid string' do
      let(:date) { '10/01/1993' }
      let(:bill) { Bill.new }

      it 'assigns the value to the next_due_date attribute' do
        bill.next_due_date = date
        expect(bill.next_due_date.strftime("%m/%d/%Y")).to eql(date)
      end
    end

    context 'when the passed in value is an invalid string' do
      let(:date) { 'asfgasdfa' }
      let(:bill) { Bill.new }

      it 'will not assign the value to the next_due_date attribute' do
        bill.next_due_date = date
        expect(bill.next_due_date).to be_nil
      end
    end

    context 'when the passed in value is a random value' do
      let(:date) { 1213 }
      let(:bill) { Bill.new }

      it 'will not assign the value to the next_due_date attribute' do
        bill.next_due_date = date
        expect(bill.next_due_date).to be_nil
      end
    end
  end

  describe '#update_bill' do
    let(:bill) { create(:bill) }
    let(:params) do
      {
        amount: 100.1,
        name: 'Apple',
        next_due_date: '03/23/2019',
        category: create(:category).id,
        repeat_interval: create(:repeat_interval).id
      }

      it 'updates the bill' do
        bill.update_bill(params)
        bill.reload
        expect(bill.name).to eql('Apple')
        expect(bill.amount).to eql(100.1)
      end
    end
  end
end
