module Refinery
  module SearchHelper

    def result_title(result)
      result.title.gsub /(#{Regexp.escape(params[:query])})/i, '<mark>\1</mark>'
    end

    def result_type(result)
      type = result.class.to_s.titleize.split("/").last

      case type
      when 'Post'
        "Innovando"
      when 'Experience'
        "Experiencia"
      else
        type
      end
    end

    # this is where you register your result URLs based on the
    # type of result we're dealing with
    def result_url(result)
      if result.respond_to? :url
        refinery.url_for result.url
      else
        refinery.url_for send(Refinery.route_for_model(result.class, :admin => false), result, highlight: params[:query])
      end
    end

    def result_author(result)
      return result.user.username.humanize if result.respond_to?(:user) && result.user.present?
      return result.author.username.humanize if result.respond_to?(:author) && result.author.present?
      ""
    end

    def result_content_teaser(result)
      content = result.respond_to?(:body) ? result.body : result.content

      truncated_content = truncate(content, {
        :length => Refinery::Blog.post_teaser_length,
        :preserve_html_tags => true
      }).html_safe
      strip_tags(truncated_content).gsub /(#{Regexp.escape(params[:query])})/i, '<mark>\1</mark>'
    end
  end
end