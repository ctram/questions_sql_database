class Question
  def self.all
    questions = QuestionsDatabase.execute('SELECT * FROM questions')
    questions.map do |question|
      Question.new(question)
    end
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
         *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_reader :id
  attr_accessor :title, :body, :user_id

  def initialize(options={})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def likers
    QuestionLike.likers_for_question(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end
end
