rails g controller Pages home about contact
rails g model gender name:string
rails g scaffold user first_name:string middle_name:string last_name:string gender_id:integer birthdate:date username:string password_digest:string --haml
rails g model email_type name:string
rails g model email address:string email_type_id:integer user_id:integer
rails g model phone_type name:string
rails g model phone number:string user_id:integer phone_type_id:integer
rails g model state name:string
rails g model address_type name:string
rails g model address line_1:string line_2:string line_3:string city:string state_id:integer zip:string user_id:integer address_type_id:integer
