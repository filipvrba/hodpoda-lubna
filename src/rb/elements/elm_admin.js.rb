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

    self.innerHTML = "<elm-admin-dashboard></elm-admin-dashboard>"
  end

  def init_elm()
    template = """
    <elm-admin-login></elm-admin-login>
    """

    self.innerHTML = template
  end
end