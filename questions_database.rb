require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def self.execute(*args)
    instance.execute(*args)
  end

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end
