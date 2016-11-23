class Changecolumnname < ActiveRecord::Migration
  def change
    rename_column :documents, :type, :doctype
  end
end
