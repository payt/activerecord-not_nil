# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  host: 'localhost',
  database: 'activerecord-not_nil_test'
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Migration.create_table(:fake_records, force: true) do |t|
  t.string :name
  t.boolean :active
  t.integer :rank
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
  FileUtils.rm('activerecord-not_nil_test')
  FileUtils.rm('activerecord-not_nil_test-shm')
  FileUtils.rm('activerecord-not_nil_test-wal')
end
