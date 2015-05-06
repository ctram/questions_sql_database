require_relative  'questions_database'
require_relative  'question'

class User
  include Saveable

  def self.all
    users = QuestionsDatabase.execute('SELECT * FROM users')
    users.map do |user|
      User.new(user)
    end
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL
    users.map do |user|
      User.new(user)
    end
  end

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def average_karma
    avg_karma = QuestionsDatabase.execute(<<-SQL, @id)
      SELECT
        (CAST(COUNT(question_likes.id) AS float)  / CAST(COUNT(DISTINCT questions.id) AS float)) as avg_likes
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
    SQL
    avg_karma.first['avg_likes'].round(2)
  end

  def authored_questions
    return nil unless @id
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def save
    if @id
      QuestionsDatabase.execute(<<-SQL, self.fname, self.lname, @id )
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          users.id = ?;
      SQL
    else
      QuestionsDatabase.execute(<<-SQL, self.fname, self.lname )
        INSERT INTO
          users ('fname', 'lname')
        VALUES
          (?, ?);
      SQL
    end
  end

end
