module ApplicationHelper
  def blog_post_teaser(post)
    if post.respond_to?(:custom_teaser) && post.custom_teaser.present?
      strip_tags(post.custom_teaser.html_safe)
    else
      truncated_content = truncate(post.body, {
        :length => Refinery::Blog.post_teaser_length,
        :preserve_html_tags => true
      }).html_safe
      strip_tags(truncated_content)
    end
  end
  
  def content_teaser(content)
    truncated_content = truncate(content.content, {
      :length => Refinery::Blog.post_teaser_length,
      :preserve_html_tags => true
    }).html_safe
    strip_tags(truncated_content)
  end
  
  def extract_images(html)
    Nokogiri::HTML(html).xpath("//img/@src")
  end
end
