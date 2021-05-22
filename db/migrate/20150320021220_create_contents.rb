class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.text :body
      t.timestamps null: false
    end
  end
end
