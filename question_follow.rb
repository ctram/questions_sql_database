class QuestionFollow

  def self.followed_questions_for_user_id(user_id)
    followed_questions = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
         questions.id, questions.title, questions.body, questions.user_id
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        users.id = ?;
    SQL

    followed_questions.map { |question| Question.new(question) }
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      JOIN
        questions ON questions.id = question_follows.question_id
      WHERE
        questions.id = ?;
    SQL
    followers.map {|follower| User.new(follower)}
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.id) DESC LIMIT ?;
    SQL
    questions.map{|question| Question.new(question)}
  end
end
