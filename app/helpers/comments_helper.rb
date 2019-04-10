module CommentsHelper
	def nested_comments(comments)
	  comments.map do |comment, sub_comment| #the comments.map also gives me an error if I choose to render the comments without the .arrange ancestry method 
	    render(comment) + content_tag(:div, nested_comments(sub_comment), class:  "nested-comments")
	  end.join.html_safe
	end
end
