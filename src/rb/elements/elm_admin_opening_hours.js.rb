import 'ElmAlert', './elm_alert'

export default class ElmAdminOpeningHours < HTMLElement
  def initialize
    super

    self.innerHTML = "<elm-spinner class='text-center mt-5 mb-5'></elm-spinner>"
    
    __bef_db.get("SELECT monday, tuesday, wednesday, " +
                 "thursday, friday, saturday, sunday " +
                 "FROM opening_hours; WHERE user_id=1") do |rows|
      week = rows[0].values().map(lambda {|item| item ? item.split('-') : ['', ''] })
      data = {
        opening_hours: week,
      }
      init_elm(data)
    end

    window.aoh_save_click = save_click
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def save_click()
    l_day_values = lambda do |day|
      return [
        document.get_element_by_id("#{day}_od").value,
        document.get_element_by_id("#{day}_do").value
      ]
    end
    days = []
    "pondeli utery streda ctvrtek patek sobota nedele".split(' ').each do |day|
      times = l_day_values(day)
      days << ((times[0].empty? || times[1].empty?) ? '' : times.join('-'))
    end

    __bef_db.set("UPDATE opening_hours SET monday = '#{days[0]}', " +
                 "tuesday = '#{days[1]}', wednesday = '#{days[2]}', " +
                 "thursday = '#{days[3]}', friday = '#{days[4]}', " +
                 "saturday = '#{days[5]}', sunday = '#{days[6]}' " +
                 "WHERE user_id = 1;") do |is_save|
      if is_save
        Events.emit('#app', ElmAlert::ENVS::SHOW, {
          end_time: 7,
          message: "Otevírací doba byla úspěšně uložena."
        })
        window.scroll_to(0, 0)
      end
    end
  end

  def init_elm(data)
    template = """
<div class='tab-pane fade active show col-lg-8 mx-auto' id='nav-opening-hours' role='tabpanel' aria-labelledby='nav-opening-hours-tab'>
  <table class='table table-bordered'>
    <thead>
      <tr>
        <th>Den</th>
        <th>Od</th>
        <th>Do</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Pondělí</td>
        <td><input type='time' class='form-control' name='pondeli_od' id='pondeli_od' value='#{data.opening_hours[0][0]}'></td>
        <td><input type='time' class='form-control' name='pondeli_do' id='pondeli_do' value='#{data.opening_hours[0][1]}'></td>
      </tr>
      <tr>
        <td>Úterý</td>
        <td><input type='time' class='form-control' name='utery_od' id='utery_od' value='#{data.opening_hours[1][0]}'></td>
        <td><input type='time' class='form-control' name='utery_do' id='utery_do' value='#{data.opening_hours[1][1]}'></td>
      </tr>
      <tr>
        <td>Středa</td>
        <td><input type='time' class='form-control' name='streda_od' id='streda_od' value='#{data.opening_hours[2][0]}'></td>
        <td><input type='time' class='form-control' name='streda_do' id='streda_do' value='#{data.opening_hours[2][1]}'></td>
      </tr>
      <tr>
        <td>Čtvrtek</td>
        <td><input type='time' class='form-control' name='ctvrtek_od' id='ctvrtek_od' value='#{data.opening_hours[3][0]}'></td>
        <td><input type='time' class='form-control' name='ctvrtek_do' id='ctvrtek_do' value='#{data.opening_hours[3][1]}'></td>
      </tr>
      <tr>
        <td>Pátek</td>
        <td><input type='time' class='form-control' name='patek_od' id='patek_od' value='#{data.opening_hours[4][0]}'></td>
        <td><input type='time' class='form-control' name='patek_do' id='patek_do' value='#{data.opening_hours[4][1]}'></td>
      </tr>
      <tr>
        <td>Sobota</td>
        <td><input type='time' class='form-control' name='sobota_od' id='sobota_od' value='#{data.opening_hours[5][0]}'></td>
        <td><input type='time' class='form-control' name='sobota_do' id='sobota_do' value='#{data.opening_hours[5][1]}'></td>
      </tr>
      <tr>
        <td>Neděle</td>
        <td><input type='time' class='form-control' name='nedele_od' id='nedele_od' value='#{data.opening_hours[6][0]}'></td>
        <td><input type='time' class='form-control' name='nedele_do' id='nedele_do' value='#{data.opening_hours[6][1]}'></td>
      </tr>
    </tbody>
  </table>
  <div class='text-center'>
    <button class='btn btn-warning' onclick='aohSaveClick()'>Uložit</button>
  </div>
</div>
    """

    self.innerHTML = template
  end
end