module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Moving Stories"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def remove_link_html text = ''
    text = ' ' + text unless text.nil?
    raw("<span class='glyphicon glyphicon-trash'></span>") + text
  end
  
  def add_link_html text = ''
    text = ' ' + text unless text.nil?
    raw("<span class='glyphicon glyphicon-plus-sign'></span>") + text
  end
  
  def back_link_html text = ''
    text = ' ' + text unless text.nil?    
    raw("<span class='glyphicon glyphicon-arrow-left'></span>") + text
  end
  
  def edit_link_html text = ''
    text = ' ' + text unless text.nil?
    raw("<span class='glyphicon glyphicon-edit'></span>") + text
  end
  
end
