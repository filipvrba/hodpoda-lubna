import 'openingHoursObj', '../../json/opening_hours.json'

export default class ElmOpeningHours < HTMLElement
  def initialize
    super
    
    init_elm()
  end
  
  def opening_hours
    opening_hours_obj.month.march
  end

  def init_elm()
    template = """
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <ul class='list-group'>
    #{subinit_elm()}
  </ul>
</section>
    """

    self.innerHTML = template
  end

  def subinit_elm()
    dom_days = []
    opening_hours.days.each do |values|
      template = """
<li class='list-group-item'><strong>#{values.day}:</strong> #{values.clock.from} - #{values.clock.to} hod.</li>
      """
      dom_days << template
    end

    return dom_days.join('')
  end
end