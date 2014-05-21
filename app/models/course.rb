class Course
  include RemoteCourse

  def initialize(attributes)
    @attributes = attributes
    create_methods
  end

  def self.get_course(course_id)
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{course_id}?include=syllabus_body", body: {
      access_token: ACCESS_TOKEN
    })
    self.new(JSON.parse(response.body))
  end

  def pages
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{self.id}/pages", body: {
      access_token: ACCESS_TOKEN
    })
    JSON.parse(response.body)
  end


  private

  def create_methods
    @attributes.each do |key, value|
      self.class.send(:attr_accessor, key)
      instance_variable_set("@#{key}", value)
    end
  end



end