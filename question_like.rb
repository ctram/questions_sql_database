
class QuestionLike
  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.id = ?;
    SQL
    users.map{ |user| User.new(user) }
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        users.id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.id) DESC LIMIT ?;
    SQL
    questions.map { |question| Question.new(question) }
  end

  def self.num_likes_for_question_id(question_id)
    count = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS COUNT
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL

    count.first["COUNT"]
  end

end
