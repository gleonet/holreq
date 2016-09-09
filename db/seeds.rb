# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
connection = ActiveRecord::Base.connection()
connection.execute("insert into teams (name, manager_id, created_at, updated_at) values ('admin', 1, now(), now());")
team = Team.first

site = Site.create!(name: 'admin')

user = User.create!(firstname: '', lastname: 'admin', login: 'admin', enabled: true,
             role: User::ADMIN, email: 'admin@example.com', site_id: site.id,
             password: 'admin', password_confirmation: 'admin', team_id: team.id
            )

team.manager_id = user.id
team.save
