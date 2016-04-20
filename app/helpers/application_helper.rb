module ApplicationHelper
  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url = urls.length > 2 ? urls[2] : nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = 'active'
      end
      items << content_tag('li', raw(link), class: item_class)
    end
    content_tag('ul', raw(items.join(EMPTY_STRING)), opts)
  end
  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag(:div, link_to('x', '#', :class => 'close', 'data-dismiss' => 'alert') + message, class: "alert alert-#{type}")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end
end
