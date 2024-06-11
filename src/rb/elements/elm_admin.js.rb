import 'ElmAdminLogin', './elm_admin_login'

export default class ElmAdmin < HTMLElement
  def initialize
    super
    @h_admin_login = lambda { |e| admin_login(e.detail.value) }
    
    init_elm()
  end

  def connected_callback()
    Events.connect('#app', ElmAdminLogin::ENVS[:login], @h_admin_login)
  end

  def disconnected_callback()
    Events.disconnect('#app', ElmAdminLogin::ENVS[:login], @h_admin_login)
  end

  def admin_login(is_correct)
    unless is_correct
      Events.emit('#app', ElmAdminLogin::ENVS[:validation], is_correct)
      return
    end

    Cookie.set("loggedIn", "true", 30)
    init_elm()
  end

  def init_elm()
    is_logged_in = Cookie.get('loggedIn') == 'true'
    template = "<elm-admin-login></elm-admin-login>"

    puts Cookie.get('loggedIn'), is_logged_in

    if is_logged_in
      template = "<elm-admin-dashboard></elm-admin-dashboard>"
    end

    self.innerHTML = template
  end
end