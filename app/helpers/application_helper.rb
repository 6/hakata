module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def m(string)
    return '' if !string 
    RDiscount.new(string).to_html.html_safe
  end
  
  def view_display_none?(position)
    output = "style='display:none;'"
    if position == 'front' && session[:cardview] == 'front'
      output = ''
    elsif position == 'center' && session[:cardview] == 'center'
      output = ''
    elsif position == 'back' && session[:cardview] == 'back'
      output = ''
    end
    return output
  end
end
