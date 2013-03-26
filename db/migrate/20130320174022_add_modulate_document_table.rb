class AddModulateDocumentTable < ActiveRecord::Migration
  def up

    create_table :modulate_documents do |z|
      z.integer             :attached_by_id, null: false
      z.integer             :attachable_id, null: false
      z.string              :attachable_type, null: false
      z.string              :attachment, null: false
      z.string              :content_type, null: false
      z.string              :filename, null: false
      z.string              :bucket, null: false
      z.string              :key, null: false
      z.string              :label
      z.boolean             :public, null: false, default: 0 

      z.timestamps
    end

    add_index :modulate_documents, :key, unique: true

  end

  def down
    drop_table :modulate_documents
  end

end
