export default class ElmMap < HTMLElement
  def initialize
    super
    
    @picnice_uri = "https://mapy.cz/letecka?vlastni-body&ut=Pivnice%20za%20KD&uc=97-lsxT.es&ud=49%C2%B013%273.614%22N%2C%2017%C2%B024%273.136%22E&x=17.4010992&y=49.2178659&z=19"

    init_elm()
  end

  def init_elm()
    template = """
<section class='mb-4 text-center'>
  <h2>Kde nás najdete</h2>
  <p>Najdete nás za Kulturním domem, vedle hlavní cesty. Před hospodou je spousta laviček a dětské hřiště, což usnadňuje orientaci. V době, kdy je pivnice otevřena, nás snadno uvidíte, jak obsluhujeme hosty. K nám se můžete dostat pěšky, kde na vás před kulturním domem čeká několik schodů. Pokud preferujete automobil, můžete pohodlně přijet a zaparkovat vedle kulturního domu na konci cesty.</p>
  <a href='#{@picnice_uri}' target='_blank'>
    <img src='/jpg/map_01.jpg' class='img-fluid' alt='Mapa s polohou hospody'>
  </a>
</section>
    """

    self.innerHTML = template
  end
end