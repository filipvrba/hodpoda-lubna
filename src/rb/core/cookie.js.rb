class Cookie
  def self.get(name)
    nameEQ = "#{name}="
    ca     = document.cookie.split(';')

    (0 ... ca.length).each do |i|
      c = ca[i]
      while c.char_at(0) == ' '
        c = c.substring(1, c.length)
        
        if c.index(nameEQ) == 0
          return c.substring(nameEQ.length, c.length)
        end
      end
    end

    return nil
  end

  def self.set(name, value, minutes)
    expires = ""

    if minutes
      date = Date.new
      date.set_time(date.get_time() + (minutes * 60 * 1_000))
      expires = "; expires=" + date.toUTC_string()
    end

    document.cookie = "#{name}=#{(value || "")}#{expires}; path=/; Secure; SameSite=Strict"
  end

  def self.erase(name)
    document.cookie = "#{name}=; Max-Age=-99999999; path=/; Secure; SameSite=Strict"
  end
end
window.Cookie = Cookie