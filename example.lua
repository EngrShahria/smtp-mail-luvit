local smtp = require("smtp")

local Mail = smtp:new({
    host = "smtp.localhost",
    port = 465,
    tls = true,
    isAuth = true
})


Mail:addAuth("myemail@love.com", "SecretPassword")
Mail:addMail("myemail@love.com", "awesomemail@mail.com")
Mail:addHead({
    from = "John Doe <myemail@love.com>",
    to = "John Doe the Second <awesomemail@mail.com>",
    subject = "This is a  Subject"
})
Mail:addBody([[
    <h1>Hello World</h1>
]])

Mail:Send(function(text)
    p(text)
end)