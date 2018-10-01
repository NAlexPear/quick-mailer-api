class CreateErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :errors do |t|
      t.integer :failure_type, default: 1
      t.belongs_to :message

      t.timestamps
    end
  end
end
