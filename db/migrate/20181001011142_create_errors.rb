class CreateErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :errors do |t|
      t.string :type
      t.belongs_to :message

      t.timestamps
    end
  end
end
