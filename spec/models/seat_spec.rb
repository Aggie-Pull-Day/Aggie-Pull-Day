# frozen_string_literal: true

require 'faker'
require 'rails_helper'

RSpec.describe Seat, type: :model do
  before :all do
    (1..26).each do |i|
      seat_number = i.chr + i.to_s
      if Seat.where(seatnumber: seat_number).empty?
        Seat.create(seatnumber: seat_number, assigned: Faker::Boolean.boolean(true_ratio: 0.5))
      end
    end
  end

  describe 'model' do
  end
end
