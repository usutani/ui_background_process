class CreateConverts < ActiveRecord::Migration[7.0]
  def change
    create_table :converts do |t|
      t.integer :status, default: 0, null: false
      t.text :message

      t.timestamps
    end
  end
end
