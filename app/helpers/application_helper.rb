module ApplicationHelper #This module declaration allows us to have the full_title function available in all our views
    def full_title(page_title = '')
      base_title = "Nick Resnick's Blog"
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
    end
  end
