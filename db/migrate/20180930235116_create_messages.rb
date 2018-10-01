class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.text :subject
      t.references :error

      t.timestamps
    end
  end
end
