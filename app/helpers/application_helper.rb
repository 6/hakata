module ApplicationHelper

  def already_voted? m
    m.votes.each do |v|
      if v.user_id = current_user.id
        return true
      end
    end
    return false
  end

  def echo_position(listizations, list)
    output = ''
    listizations.each do |lz|
      if lz.list_id == list.id
        output = lz.position.to_s
      end
    end
    return output
  end

  def title(page_title)
    if page_title
      content_for(:title) { page_title + ' | Lazy Genius' }
    else
      content_for(:title) { 'Lazy Genius' }
    end
  end
  
  def m(string)
    return '' if !string 
    RDiscount.new(string).to_html.html_safe
  end
  
  def view_display_none?(position, list_mode_off)
    output = "style='display:none;'"
    if !list_mode_off && position == 'front' && session[:cardview] == 'front'
      output = ''
    elsif !list_mode_off && position == 'center' && session[:cardview] == 'center'
      output = ''
    elsif !list_mode_off && position == 'back' && session[:cardview] == 'back' 
      output = '' 
    elsif list_mode_off && position == 'center'
      output = ''
    end
    return output
  end
end
