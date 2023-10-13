# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'activerecord-not_nil_test'
)

ActiveRecord::Tasks::PostgreSQLDatabaseTasks.new(ActiveRecord::Base.connection_db_config).purge

ActiveRecord::Migration.verbose = false

ActiveRecord::Migration.create_table(:fake_records, force: true) do |t|
  t.string :name
  t.boolean :active
  t.integer :rank
  t.jsonb :details
  t.integer :list, array: true
  t.integer :enumerized, default: 0, null: false

  t.timestamps null: true

  t.index %i[name rank], unique: true
end

ActiveRecord::Migration.create_table(:phony_records, id: false, force: true) do |t|
  t.references :fake_record
  t.string :name
  t.boolean :active
end

class FakeRecord < ActiveRecord::Base
  has_many :phony_records
end

class PhonyRecord < ActiveRecord::Base
  belongs_to :fake_record
end

class Minitest::Test
  include ::ActiveRecord::TestFixtures

  fixture_paths << 'test/fixtures'
  fixtures :all
end

Minitest.after_run do
  ActiveRecord::Migration.drop_table(:fake_records)
end
