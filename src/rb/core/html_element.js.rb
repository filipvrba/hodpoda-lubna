def dom_element()
  self.constructor.name.gsub(/([a-z])([A-Z])/, '$1-$2').downcase
end
HTMLElement.prototype.dom_element = dom_element