class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :desc
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
