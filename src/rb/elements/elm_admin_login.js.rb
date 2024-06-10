import 'CryptoJS', 'crypto-js'

export default class ElmAdminLogin < HTMLElement
  ENVS = {
    login: 'al0',
    validation: 'al1',
  }

  def initialize
    super
    
    @h_admin_validation = lambda { |e| validation_admin_password(e.detail.value) }

    init_elm()
    @input_password_dom = document.get_element_by_id('adminPassword')

    window.admin_check_password = admin_check_password
    window.admin_password_input_change = admin_password_input_change
  end

  def connected_callback()
    Events.connect('#app', ElmAdminLogin::ENVS[:validation], @h_admin_validation)
  end

  def disconnected_callback()
    Events.disconnect('#app', ElmAdminLogin::ENVS[:validation], @h_admin_validation)
  end

  def admin_check_password()
    plain_password  = @input_password_dom.value
    hashed_password = CryptoJS::MD5(plain_password).to_s
    correct_password = '21232f297a57a5a743894a0e4a801fc3'

    is_correct = hashed_password == correct_password
    Events.emit('#app', ElmAdminLogin::ENVS[:login], is_correct)
  end

  def admin_password_input_change()
    if @input_password_dom.class_list.contains('is-invalid')
      validation_admin_password(true)
    end
  end

  def validation_admin_password(is_valid)
    if is_valid
      @input_password_dom.class_list.remove('is-invalid')
    else
      @input_password_dom.class_list.add('is-invalid')
    end
  end

  def init_elm()
    template = """
<div id='adminPasswordForm' class='col-md-6 mx-auto text-center'>
  <input type='password' class='form-control' id='adminPassword' oninput='adminPasswordInputChange()' placeholder='Zadejte heslo' aria-describedby='validationAdminPasswordFeedback' required>
  <div id='validationAdminPasswordFeedback' class='invalid-feedback'>
    Při přihlášení jste zadali špatné heslo!
  </div>

  <button class='btn btn-primary mt-3 mb-5' onclick='adminCheckPassword()'>Přihlásit se</button>
  <div class='alert alert-warning mb-3' role='alert'>
    <em>Pro přístup k administraci tohoto webu je nutné se přihlásit. Po úspěšném přihlášení jako správce budete moci upravovat a spravovat obsah stránky.</em>
  </div>
</div>
    """

    self.innerHTML = template
  end
end