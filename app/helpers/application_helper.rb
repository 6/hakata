module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
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
