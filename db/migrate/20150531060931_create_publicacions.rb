class CreatePublicacions < ActiveRecord::Migration
  def change
    create_table :publicacions do |t|
      t.string :titulo
      t.string :contenido

      t.timestamps
    end
  end
end
