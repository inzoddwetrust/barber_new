class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :client do |t|
      t.text :name
      t.text :phones
      t.text :datestamp
      t.text :barber
      t.text :color
    end
  end
end
