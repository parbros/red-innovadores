class Course < ActiveRecord::Base
  attr_accessible :enroll_available, :remote_courses_id

  has_many :enrolls

  include RemoteCourse

  def self.get_courses
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses?all=true&state[]=available&state[]=completed&include=syllabus_body", body: {
      access_token: ACCESS_TOKEN
    })
    @courses ||= JSON.parse(response.body)
    @courses.sort {|course| course['id']}.map {|course| course_from_remote_course(course)}
  end

  def self.get_course(course_id)
    course = find_or_initialize_by_remote_courses_id course_id
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{course_id}?include=syllabus_body", body: {
      access_token: ACCESS_TOKEN
    })
    course.set_remote_course JSON.parse(response.body)
    course
  end

  def self.course_from_remote_course(remote_course)
    course = find_or_create_by_remote_courses_id(remote_course['id'])
    course.set_remote_course(remote_course)
    course
  end

  def pages
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{self.get_remote_attribute('id')}/pages", body: {
      access_token: ACCESS_TOKEN
    })
    @pages ||= JSON.parse(response.body)
  end

  def front_page
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{self.get_remote_attribute('id')}/front_page", body: {
      access_token: ACCESS_TOKEN
    })
    @front_page ||= JSON.parse(response.body)
  end

  def get_remote_attribute(attr)
    @remote_course[attr] if @remote_course
  end

  def set_remote_course(course_attr)
    @remote_course ||= course_attr
  end

  def get_course
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses/#{self.remote_courses_id}?include=syllabus_body", body: {
      access_token: ACCESS_TOKEN
    })
    set_remote_course JSON.parse(response.body)
  end
end
