export default class ElmSpinner < HTMLElement
  def initialize
    super
    
    init_elm()
  end

  def init_elm()
    template = """
<div class='spinner-border text-primary' role='status'>
  <span class='visually-hidden'>Loading...</span>
</div>
    """

    self.innerHTML = template
  end
end