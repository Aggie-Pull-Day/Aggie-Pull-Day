class CreatePullTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :pull_times do |t|
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
