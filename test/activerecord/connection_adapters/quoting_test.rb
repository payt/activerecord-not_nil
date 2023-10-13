# frozen_string_literal: true

require './test/test_helper'

describe ActiveRecord do
  it 'works with where clauses' do
    assert_equal(FakeRecord.where(name: not_nil).count, 3)
  end

  it 'works with a join' do
    assert_equal(FakeRecord.joins(:phony_records).where(name: not_nil).count, 3)
  end

  it 'works with a named function' do
    assert_equal(FakeRecord.where('lower(name) = ?', 'first').count, 1)
  end

  it 'raises when trying to pass not_nil into a named function' do
    assert_raises { FakeRecord.where('lower(name) = ?', not_nil).count }
  end
end
