import 'openingHoursObj', '../../json/opening_hours.json'

export default class ElmOpeningHours < HTMLElement
  DAYS = ['Pondělí', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle']

  def initialize
    super
    
    init_elm()
    __bef_db.get("SELECT monday, tuesday, wednesday, " +
                 "thursday, friday, saturday, sunday " +
                 "FROM opening_hours; WHERE user_id=1") do |rows|
      week = rows[0].values().map(lambda {|item| item ? item.split('-') : nil })
      init_elm(week)
    end
  end

  def init_elm(value = nil)
    template = """
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <elm-spinner class='mt-5 mb-5'></elm-spinner>
</section>
    """

    if value
      template = """
<section class='mb-4 text-center'>
  <h2>Otevírací Doba</h2>
  <ul class='list-group'>
    #{subinit_elm(value)}
  </ul>
</section>
      """
    end

    self.innerHTML = template
  end

  def subinit_elm(week)
    dom_days = []
    (0 ... week.length).each do |i|
      unless week[i]
        next
      end

      template = """
<li class='list-group-item'><strong>#{DAYS[i]}:</strong> #{week[i][0]} - #{week[i][1]} hod.</li>
      """
      dom_days << template
    end

    return dom_days.join('')
  end
end