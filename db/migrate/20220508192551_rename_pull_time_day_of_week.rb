class RenamePullTimeDayOfWeek < ActiveRecord::Migration[7.0]
  def change
    rename_column :pull_times, :day_of_week, :weekday
  end
end
