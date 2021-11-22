# SMTP Mail Client for Luvit!
Use SMTP mail client service using [Luvit](https://luvit.io).

It's super easy to do!
First, install smtp from Luvit package Manager (**lit**)
```lit install LeXinshou/smtp-mail``` or clone it from here, put it inside libs/deps folder.

Once you get the module, head to the main file and require it.
Code Example:
```lua
local smtp = require("smtp")
```

Create a new SMTP client  
```lua
local Mail = smtp:new()
```
If you don't want to use default value, use like
```lua
local Mail = smtp:new({
    host = "Your SMTP host",
    port = 25, --465 if you want to use SSL
    tls = false, -- true it if you want TLS service
    isAuth = false -- Make it true if you want to use AUTH
})
```
Awesome! You have created your Mail client, now before sending the email, you need to do a few step.

If you have the isAuth true, use
```lua
Mail:addAuth("UserName", "Password")
```

Add MAIL and RCPT 
```lua
Mail:addMail("email@mail.com", "anotheremail@mail.com")
```

Once you finish it, add the header data from/to/subject
```lua
Mail:addHead({
    from = "Email <email@mail.com>",
    to = "AnotherEmail <anotheremail@mail.com>",
    subject = "Cool Subject!"
})
```
Once you finish the header data, add the body part. 
**NOTE: Body can be HTML/TEXT**
```lua
Mail:addBody("This is a great body!)
```

**OR**

```lua
Mail:addBody([[
    <h1>This is a cool HTML Body</h1>
    <p>I do love the Multiline feature!</p>
]])
```

And finally! 
Send the Awesome email!

```lua
Mail:Send(function(text)
    p(text)
end)
Mail:Destroy() -- Disconnect and destroy the connected client
```


Happy Scripting!
