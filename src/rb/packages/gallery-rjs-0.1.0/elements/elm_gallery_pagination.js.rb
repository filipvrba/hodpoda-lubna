import 'ElmGallery', './elm_gallery'

export default class ElmGalleryPagination < ElmGallery
  MAX_LENGTH = 6
  PARAMETER = "gallery-index"

  def initialize
    super
    @url = URL.new(window.location.href)
    @url_params = URLSearchParams.new(@url.search)
    @page_index = get_page_index()
    

    window.change_gallery = change_gallery
    window.scroll_gallery = scroll_gallery
  end

  def get_page_index()
    is_in_range = lambda do |number, min, max|
      return number >= min && number <= max
    end

    index = @url_params.get(PARAMETER) == nil ?
      0 : @url_params.get(PARAMETER).to_i
    
    min_index = @page_index * MAX_LENGTH
    max_index = min_index + MAX_LENGTH

    if is_in_range(index, 0, pages_count)
      return index
    else
      return 0
    end
  end

  def connected_callback()
    super
  end

  def disconnected_callback()
  end

  def change_gallery(page_index)
    @page_index = page_index
    @url_params.set(PARAMETER, @page_index)
    @url.search = @url_params.to_string()
    window.history.push_state({}, '', @url)

    init_elm()
  end

  def scroll_gallery(is_left)
    if is_left
      change_gallery(@page_index - 1) if @page_index - 1 >= 0
    else
      change_gallery(@page_index + 1) if @page_index + 1 < pages_count
    end
  end

  def pages_count
    Math.ceil(GALLERY_JSON.gallery.length / MAX_LENGTH)
  end

  def relevant_gallery
    result = { gallery: [] }

    min_index = @page_index * MAX_LENGTH
    max_index = min_index + MAX_LENGTH

    (min_index...max_index).each do |i|
      if i < GALLERY_JSON.gallery.length
        result.gallery << GALLERY_JSON.gallery[i]
      else
        break
      end
    end

    return result
  end

  def init_elm()
    super
  end

  def subinit_elm()
    l_btn_numbers = lambda do
      length = pages_count

      start_index = @page_index - 1
      if length > 2
        end_index = @page_index + 1
      else
        end_index = @page_index
      end

      if start_index < 0
        start_index += 1
        end_index += 1
      elsif end_index >= length
        start_index -= 1
        end_index -= 1
      end

      result = []

      (start_index..end_index).each do |i|
        is_active = i == @page_index ? "active" : ""
        template = """
<li class='page-item'>
  <button class='page-link #{is_active}' onclick='changeGallery(#{i})'>#{i + 1}</button>
</li>
        """
        result << template
      end

      return result.join('')
    end

    return """
#{super}
<nav aria-label='Page navigation example'>
  <ul class='pagination justify-content-center'>
    <li class='page-item'>
      <button class='page-link' onclick='scrollGallery(true)'>Předchozí</button>
    </li>
    #{l_btn_numbers()}
    <li class='page-item'>
      <button class='page-link' onclick='scrollGallery(false)'>Další</button>
    </li>
  </ul>
</nav>
    """
  end
end