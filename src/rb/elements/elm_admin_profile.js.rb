import 'CryptoJS', 'crypto-js'
import 'ElmAlert', './elm_alert'

export default class ElmAdminProfile < HTMLElement
  def initialize
    super
    
    init_elm()

    @admin_input_password_new = document.get_element_by_id('adminPasswordNew')
    @admin_btn_save_password = document.get_element_by_id('adminBtnSavePassword')
    @admin_input_password_new_repeat = document.get_element_by_id('adminPasswordNewRepeat')

    window.admin_btn_save_password = admin_btn_save_password
    window.admin_password_new_input_change = admin_password_new_input_change
    window.admin_password_new_repeat_input_change = admin_password_new_repeat_input_change

    admin_password_new_input_change()
  end

  def connected_callback()
  end

  def disconnected_callback()
  end

  def init_elm()
    template = """
<div id='adminPasswordForm' class='text-center'>
  <h2>Heslo</h2>
  <p>Změna na nové heslo.</p>

  <input type='password' class='form-control' id='adminPasswordNew' oninput='adminPasswordNewInputChange()' placeholder='Zadejte nové heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Při přihlášení jste zadali špatné heslo!
  </div>
  <br>
  <input type='password' class='form-control' id='adminPasswordNewRepeat' oninput='adminPasswordNewRepeatInputChange()' placeholder='Zadejte znovu nové heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Heslo se neshoduje s tím, které bylo vyplněno jako první.
  </div>

  <button class='btn btn-warning mt-3 mb-5' id='adminBtnSavePassword' onclick='adminBtnSavePassword()'>Uložit</button>
</div>
    """

    self.innerHTML = template
  end

  def admin_password_new_input_change()
    @admin_btn_save_password.disabled = @admin_input_password_new.value.length == 0 ||
      @admin_input_password_new_repeat.value.length == 0
  end

  def admin_btn_save_password()
    if @admin_input_password_new_repeat.value == @admin_input_password_new.value
      btn_success_save_password(@admin_input_password_new.value)
    else
      @admin_input_password_new_repeat.class_list.add('is-invalid')
    end
  end

  def admin_password_new_repeat_input_change()
    admin_password_new_input_change()

    if @admin_input_password_new_repeat.class_list.contains('is-invalid')
      @admin_input_password_new_repeat.class_list.remove('is-invalid')
    end
  end

  def btn_success_save_password(new_password)
    hashed_password = CryptoJS::MD5(new_password).to_s

    __bef_db.set("UPDATE users SET password_hash = '#{hashed_password}' " +
                 "WHERE id = 1 AND is_admin=1;") do |is_save|
      if is_save
        @admin_input_password_new.value = ''
        @admin_input_password_new_repeat.value = ''
        admin_password_new_input_change()

        Events.emit('#app', ElmAlert::ENVS::SHOW, {
          end_time: 7,
          message: "Profil byl úspěšně uložen."
        })
      end
    end
  end
end