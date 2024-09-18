class AddIndexToTagColumnsOnHashtags < ActiveRecord::Migration[7.1]
  def change
    add_index :hashtags, 'LOWER(tag)', unique: true, name: 'index_hashtags_on_lower_tag'
  end
end
