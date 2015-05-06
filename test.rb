require_relative 'question_like'
require_relative 'question_follow'
require_relative 'user'
require_relative 'question'
require_relative 'reply'

user = User.all.first
reply = Reply.all.first
reply2 = Reply.all[1]
# p reply2

# p reply.author
# p reply.question
# p reply.parent_reply
# p reply2.parent_reply
#
# p question = Question.all.first
# p question.author
# p question.replies
#
# p user.authored_questions
# p user.authored_replies
# p QuestionFollow.followed_questions_for_user_id(1)
# puts
# p QuestionFollow.followed_questions_for_user_id(2)
# puts
# p QuestionFollow.followed_questions_for_user_id(3)
#
# p QuestionFollow.followers_for_question_id(1)
# puts
# p QuestionFollow.followers_for_question_id(2)
# puts
# p QuestionFollow.followers_for_question_id(3)
# puts
# p QuestionFollow.followers_for_question_id(4)

# p QuestionFollow.most_followed_questions(2)


# p QuestionLike.num_likes_for_question_id(1)
# p QuestionLike.num_likes_for_question_id(2)
# p QuestionLike.num_likes_for_question_id(3)

# p QuestionLike.likers_for_question_id(4)
# puts
# p QuestionLike.liked_questions_for_user_id(3)
# puts
# p QuestionLike.most_liked_questions(2)
#
# p Question.most_liked(2)
# p user.average_karma
puts 'new user'
p user = User.new('fname' => 'newguy', 'lname' => 'guy')
puts 'save user'
p user.save
puts 'All users'
p User.all
user.fname = 'MAD'
user.lname = 'MAX'
p user.save
p User.all
