# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

author = User.create!(handle: "the-real-author", name: "Any Author")
friend = User.create!(handle: "your-friend", name: "Any Friend")
_no_dms = User.create!(handle: "no-sliding-into-my-dms!", name: "No DMs")

dm_author = author.create_direct_depot!
dm_friend = friend.create_direct_depot!

author.authored_messages.create!(depot: dm_author, content: "Is this thing on?")
author.authored_messages.create!(depot: dm_friend, content: "Hello? Can you hear me?")
friend.authored_messages.create!(depot: dm_author, content: "Can you hear me?")
