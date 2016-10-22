class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :author
      t.string :type
      t.string :category
      t.text :keywords
      t.text :pdflink

      t.timestamps null: false
    end
  end
end
