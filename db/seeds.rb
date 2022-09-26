user = User.new(name: "dummbel",
  email: "dumble@m.com",
  password:"foobar foobar",
  password_confirmation: "foobar foobar",
  bio:"",
  ARMU: true,
  birth_date:"1997-11-11",
  admin: true,
  skip_password_validation:true
)
user.save#(validate: false)