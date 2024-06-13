class URLParams
  def self.get(parameter)
    url        = URL.new(window.location.href)
    url_params = URLSearchParams.new(url.search)

    url_params.get(parameter)
  end

  def self.set(parameter, value)
    url        = URL.new(window.location.href)
    url_params = URLSearchParams.new(url.search)

    url_params.set(parameter, value)
    url.search = url_params.to_string()
    window.history.push_state({}, '', url)
  end

  def self.get_index(parameter)
    param = URLParams.get(parameter)
    param == nil ? 0 : param.to_i
  end
end
window.URLParams = URLParams