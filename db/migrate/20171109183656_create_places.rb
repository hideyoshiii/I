class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :title
      t.string :author
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
