function domElement() {
  return this.constructor.name.replaceAll(/([a-z])([A-Z])/g, "$1-$2").toLowerCase()
};

HTMLElement.prototype.domElement = domElement