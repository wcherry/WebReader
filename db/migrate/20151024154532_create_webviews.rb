class CreateWebviews < ActiveRecord::Migration
  def change
    create_table :webviews do |t|
      t.string :url
      t.integer :line_number
      t.timestamps
    end
  end
end
