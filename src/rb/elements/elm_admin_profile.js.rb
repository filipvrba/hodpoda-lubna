export default class ElmAdminProfile < HTMLElement
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
<p>lol</p>
    """

    self.innerHTML = template
  end
end