class CreateMessageThreadsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :message_threads_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :message_thread

      t.timestamps
    end
  end
end
