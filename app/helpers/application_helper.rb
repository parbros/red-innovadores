module ApplicationHelper
  def blog_post_teaser(post)
    if post.respond_to?(:custom_teaser) && post.custom_teaser.present?
      post.custom_teaser.html_safe
    else
      truncate(post.body, {
        :length => Refinery::Blog.post_teaser_length,
        :preserve_html_tags => true
      }).html_safe
    end
  end
  
  def content_teaser(content)
    truncate(content.content, {
      :length => Refinery::Blog.post_teaser_length,
      :preserve_html_tags => true
    }).html_safe
  end
end
