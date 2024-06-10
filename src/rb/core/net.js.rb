import ['ENV'], '../env'

export default class Net
  SQL_ERR = 'SQL Error'

  def self.curl(url, &callback)
    fetch(url)
    .then(lambda do |response|
      response.text()
    end)
    .then(lambda do |text|
      callback(text) if callback
    end)
  end

  def self.bef_json(url, &callback)
    fetch(url)
    .then(lambda do |response|
      response.json()
    end)
    .then(lambda do |data|
      if data.status_code
        console.error("GET: #{data.status_code} #{data.status}")
        callback([]) if callback
      else
        callback(data) if callback
      end
    end)
  end

  def self.bef_send(method, query, &callback)
    method = method.upcase()

    puts query
    
    fetch(ENV::VITE_URL_API, {
      method: method,
      headers: {
        'Token': ENV::VITE_BEF_SERVER,
        'Database': ENV::VITE_DATABASE,
        'Query': query,
      }
    })
    .then(lambda do |response|
      response.json()
    end)
    .then(lambda do |data|
      if data.status_code == 403 || data.status_code == 405 ||
         data.status == SQL_ERR
        console.error("#{method}: #{data.status_code} #{data.status}")
        callback(false) if callback
      else
        callback(true) if callback
      end
    end)
  end
end
window.Net = Net
