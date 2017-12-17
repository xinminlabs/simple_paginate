# models
class User < ActiveRecord::Base
end

#migrations
class CreateAllTables < ActiveRecord::Migration[4.2]
  def self.up
    create_table(:users) { |t| t.string :name; t.integer :age }
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up
