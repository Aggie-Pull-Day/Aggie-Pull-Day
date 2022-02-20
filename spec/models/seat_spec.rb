# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seat, type: :model do
  before :all do
    (65..90).each do |i|
      (1..30).each do |j|
        seat_number = i.chr + j.to_s
        Seat.create(seatnumber: seat_number, assigned: (j % 2).zero?) if Seat.where(seatnumber: seat_number).empty?
      end
    end
  end

  describe 'model' do
    xit 'has the correct amount of data' do
      expect(Seat.all.length).to eq 780
    end

    xit 'loads seats based on a single attribute' do
      not_pulled = Seat.where(assigned: false)
      expect(not_pulled).to eq 390
    end

    xit 'loads seats based on multiple attributes' do
      not_pulled = Seat.where(assigned: false)
      not_pulled_row_a = not_pulled.where('seatnumber LIKE :prefix', prefix: 'A%')
      expect(not_pulled_row_a.length).to eq 15
    end

    xit 'successfully deletes data based on a single attribute' do
      Seat.where('seatnumber LIKE :prefix', prefix: 'A%').destroy_all
      expect(Seat.all.length).to eq 750
    end

    xit 'successfully deletes data based on multiple attributes' do
      Seat.where(seatnumber: 'B1', assigned: false).destroy_all
      expect(Seat.all.length).to eq 749
    end
  end
end
