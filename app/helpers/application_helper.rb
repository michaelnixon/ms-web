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
  
  def remove_link_html(text = '')
    base_link = raw("<span class='glyphicon glyphicon-trash'></span>")
    if text.empty?
      base_link
    else
      "#{base_link} #{text}"
    end
  end
  
  def add_link_html text = ''
    base_link = raw("<span class='glyphicon glyphicon-plus-sign'></span>")
    if text.empty?
      base_link
    else
      "#{base_link} #{text}"
    end    
  end
  
  def back_link_html text = ''
    base_link = raw("<span class='glyphicon glyphicon-arrow-left'></span>")
    if text.empty?
      base_link
    else
      "#{base_link} #{text}"
    end 
  end
  
  def edit_link_html text = ''
    base_link = raw("<span class='glyphicon glyphicon-arrow-edit'></span>")
    if text.empty?
      base_link
    else
      "#{base_link} #{text}"
    end    
  end
  
end
