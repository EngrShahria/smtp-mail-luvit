local net = require("coro-net")
local b64 = require("base64").encode

local Object = require("core").Object

local mail = Object:extend()

function mail:initialize(...)
    local opt = (...)
    self.host = opt.host or "127.0.0.1"
    self.port = opt.port or 25
    self.tls = opt.tls or false
    self.isAuth = opt.isAuth or false
    
    self.auth = {added = false} -- user/password
    self.mail = {added = false} -- MAIL/RCPT
    self.data = {added = false} -- From/To/Sub/Body
    
    self.net = {}
    local read, write, dsocket, updateDecoder, updateEncoder, close = net.connect({port = self.port, host = self.host, tls = self.tls})
    if read == nil then 
	      print("Invalid SMTP server, please check again")
    return end
    self.net = {
        read = read, 
        write = write, 
        close = close
    }
    return true
end

function mail:addAuth(user, pass)
    if self.isAuth == false then return false end
    local user = b64(tostring(user))
    local pass = b64(tostring(pass))
    self.auth = {
        user = user, 
        pass = pass, 
        added = true
    }
    return true
end

function mail:addMail(from, to)
    self.mail = {
        from = tostring(from),
        to = tostring(to),
        added = true
    }
    return true
end

function mail:addHead(...)
    local head = (...)
    self.data.head = {
        from = head.from, 
        to = head.to,
        subj = head.subject,
        added = true
    }
end
function mail:addBody(body)
    self.data.body ={
        added = true, 
        payload = tostring(body)
    }
    return true
end

local push = "\r\n"

function mail:Send(callback)

    if self.isAuth  and not self.auth.added then
        return callback("No User/Password found") end
    if not self.mail.added then 
        return callback("No Mail data found") end
    if not self.data.head or not self.data.head.added  then 
        return callback("No header data found") end
    if not self.data.body or not self.data.body.added then 
        return callback("No body found") end
    
    local write, close, read = self.net.write, self.net.close, self.net.read
    write("EHLO FromSMTPLuvitXinshou") write(push)
    if self.isAuth and self.auth.added then
        write("AUTH LOGIN") write(push)
        write(self.auth.user) write(push)
        write(self.auth.pass) write(push)
    end
    write("MAIL FROM: <"..self.mail.from..">") write(push)
    write("RCPT TO: <"..self.mail.to..">") write(push)
    write("DATA") write(push)
    write("From: "..self.data.head.from) write(push)
    write("To: "..self.data.head.to) write(push)
    write("Subject: "..self.data.head.subj) write(push)
    write("MIME-Version: 1.0") write(push)
    write("Content-Type: text/html;") write(push)
    write(push)
    write(self.data.body.payload) write(push)
    write(".") write(push)
    write("QUIT") write(push)
    callback("Done")
end

function mail:Destroy() 
    self.net.close()
    self = nil
end

return mail
