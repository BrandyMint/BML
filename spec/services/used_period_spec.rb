require 'rails_helper'

RSpec.describe UsedPeriod do
  let(:year) { Time.current.year }

  describe '#call' do
    context 'period month == start_date month' do
      it 'first day returns 1.0' do
        (1..12).each do |month|
          days_in_month = Time.days_in_month month, year
          result = described_class.new(start_date: Date.new(year, month), period: Date.new(year, month)).call
          expect(result.ratio).to eq 1.0
          expect(result.used_days).to eq days_in_month
          expect(result.period_days).to eq days_in_month
        end
      end

      it 'last day returns 0.03' do
        (1..12).each do |month|
          days_in_month = Time.days_in_month month, year
          result = described_class.new(start_date: Date.new(year, month, days_in_month), period: Date.new(year, month)).call
          expect(result.ratio).to eq 0.03
          expect(result.used_days).to eq 1
          expect(result.period_days).to eq days_in_month
        end
      end
    end

    context 'period month > start_date month' do
      let(:year_ago) { Time.current.year - 1 }
      it 'returns 1.0' do
        (1..12).each do |month|
          days_in_month = Time.days_in_month month, year
          result = described_class.new(start_date: Date.new(year_ago, month), period: Date.new(year, month)).call
          expect(result.ratio).to eq 1.0
          expect(result.used_days).to eq days_in_month
          expect(result.period_days).to eq days_in_month
        end
      end
    end

    context 'period month < start_date month' do
      let(:year_ago) { Time.current.year - 1 }
      it 'returns 0.0' do
        (1..12).each do |month|
          days_in_month = Time.days_in_month month, year_ago
          result = described_class.new(start_date: Date.new(year, month), period: Date.new(year_ago, month)).call
          expect(result.ratio).to eq 0.0
          expect(result.used_days).to eq 0
          expect(result.period_days).to eq days_in_month
        end
      end
    end
  end
end
