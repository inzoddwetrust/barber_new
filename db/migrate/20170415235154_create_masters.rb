class CreateMasters < ActiveRecord::Migration[5.0]
  def change
    create_table :masters do |t|
      t.text :name

      t.timestamps
    end

  Master.create :name => 'Jessie Pinkman'
  Master.create :name => 'Walter White'
  Master.create :name => 'Gus Fring'
  end
end
