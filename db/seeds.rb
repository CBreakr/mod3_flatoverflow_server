# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Question.destroy_all
Comment.destroy_all
QuestionUpvote.destroy_all
CommentUpvote.destroy_all
Tag.destroy_all

u1 = User.create(name: 'codenameuriel', is_coach: false)
u2 = User.create(name: 'CBreakr', is_coach: false)
u3 = User.create(name: 'Lexscher', is_coach: true)
u4 = User.create(name: 'ipino0128', is_coach: true)
u5 = User.create(name: 'EthanJF', is_coach: true)

q1 = Question.create!(title: "First Question", text:"Lorem Ipsum", user:u1)

c1 = Comment.create!(question: q1, user: u2, text: "What?")

qu1 = QuestionUpvote.create!(question:q1, user:u3)
qu2 = QuestionUpvote.create!(question:q1, user:u4)

cu1 = CommentUpvote.create!(comment: c1, user: u1)
cu2 = CommentUpvote.create!(comment: c1, user: u5)

tag1 = Tag.create!(text: "#javascript")
tag2 = Tag.create!(text: "#rails")

q1.tags << tag1
q1.tags << tag2

q2 = Question.create!(title: "Second Question", text:"Lorem Ipsum", user:u1)
q3 = Question.create!(title: "Third Question", text:"Lorem Ipsum", user:u2)
q4 = Question.create!(title: "Fourth Question", text:"Lorem Ipsum", user:u3)
q5 = Question.create!(title: "Fifth Question", text:"Lorem Ipsum", user:u4)
q6 = Question.create!(title: "Sixth Question", text:"Lorem Ipsum", user:u5)
q7 = Question.create!(title: "Seventh Question", text:"Lorem Ipsum", user:u1)
q8 = Question.create!(title: "Eigth Question", text:"Lorem Ipsum", user:u2)
q9 = Question.create!(title: "Ninth Question", text:"Lorem Ipsum", user:u3)
q10 = Question.create!(title: "Tenth Question", text:"Lorem Ipsum", user:u4)
q11 = Question.create!(title: "Eleventh Question", text:"Lorem Ipsum", user:u5)
q12 = Question.create!(title: "Twelvth Question", text:"Lorem Ipsum", user:u1)
q13 = Question.create!(title: "Thirteenth Question", text:"Lorem Ipsum", user:u2)
q14 = Question.create!(title: "Fourteenth Question", text:"Lorem Ipsum", user:u3)

q1.created_at = DateTime.new(2001,2,3,4,5,6,Rational(3,24))
q1.save!

QuestionUpvote.create!(question:q3, user:u1)
QuestionUpvote.create!(question:q3, user:u3)
QuestionUpvote.create!(question:q3, user:u4)
QuestionUpvote.create!(question:q3, user:u5)

QuestionUpvote.create!(question:q6, user:u1)
QuestionUpvote.create!(question:q6, user:u2)
QuestionUpvote.create!(question:q6, user:u4)

c1 = Comment.create!(question: q3, user: u3, text: "Answer!")
c1 = Comment.create!(question: q3, user: u2, text: "Thanks!")
c1 = Comment.create!(question: q4, user: u2, text: "Now?")
c1 = Comment.create!(question: q5, user: u2, text: "Then?")
c1 = Comment.create!(question: q10, user: u2, text: "That?")
c1 = Comment.create!(question: q11, user: u2, text: "Here?")
