class Reply
  def self.all
    replies = QuestionsDatabase.execute('SELECT * FROM replies')
    replies.map do |reply|
      Reply.new(reply)
    end
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
         *
      FROM
        replies
      WHERE
        replies.user_id = ?;
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.question_id = ?;
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(reply_id)
    reply = QuestionsDatabase.execute(<<-SQL, reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?;
    SQL
    Reply.new(reply.first)
  end

  attr_reader :id
  attr_accessor :question_id, :reply_id, :user_id, :body

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @body = options['body']
    @question_id = options['question_id']
    @reply_id = options['reply_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    @reply_id.nil? ? [] : Reply.find_by_id(@reply_id)
  end
end
