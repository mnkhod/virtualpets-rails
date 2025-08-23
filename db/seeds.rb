User.delete_all

User.create! email_address: "mnkhod.dev@gmail.com", password: "pass", password_confirmation: "pass"
User.create! email_address: "admin@gmail.com", password: "admin", password_confirmation: "admin"
