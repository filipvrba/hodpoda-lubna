export default class ElmAdminDashboard < HTMLElement
  def initialize
    super
    
    init_elm()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
    """

    self.innerHTML = template
  end
end