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

tag1 = Tag.create!(text: "javascript")
tag2 = Tag.create!(text: "rails")

q1.tags << tag1
q1.tags << tag2