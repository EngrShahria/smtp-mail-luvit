  return {
    name = "LeXinshou/smtp-mail",
    version = "1.0.0",
    description = "Use SMTP mail client service using Luvit",
    tags = { "smtp", "mail", "luvit" },
    license = "MIT",
    author = { name = "Xinshou", email = "ShahriaFahim@live.com" },
    homepage = "https://github.com/leXinshou/smtp-mail-luvit",
    dependencies = {
    	"luvit/secure-socket",
    	"luvit/resource@2.1.0",
    	"creationix/coro-net",
      "creationix/base64"
    },
    files = {
      "**.lua",
    }
  }
  