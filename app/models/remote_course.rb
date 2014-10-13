module RemoteCourse

  CANVAS_SITE = 'http://lms.redinnovacion.org'  # The base-url for where we plan to retrieve data
  # CANVAS_SITE = 'http://localhost:3020'  # The base-url for where we plan to retrieve data

  # development access token
  # ACCESS_TOKEN = 'SKnDkEZuzp85ByfCGrkrIWrr15tHzPJJkkTRtaaWWgtaDLCCW37tUpELaUnbPWSz'

  #production access token
  ACCESS_TOKEN = 'Quuin1ofWcNJdpvw2fdaKhno1FXyQGzCnTewDwNE9FCQlBPilUHA1Fmm7Yk3asYU'
  # ACCESS_TOKEN = 'y9kCw6lTxN0G0PRaGz7vXDFCq2snEovVNSlMWSIczO6DRKJPEQ7W1XnnOeT4hRzZ'

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

  end

  def enroll_to_remote_course(course_id)
    response = Typhoeus.post("#{CANVAS_SITE}/api/v1/courses/#{course_id}/enrollments", body: {
      enrollment: {
        user_id: self.canvas_user_id,
        type: 'StudentEnrollment',
        enrollment_state: 'active',
        notify: true
      }
    },
      headers: {
        'Authorization' => "Bearer #{self.canvas_access_token}",
        'Content-Type' => 'application/x-www-form-urlencoded'
    })
    JSON.parse(response.body)
  end

  def conclude_a_remote_course(course_id, enroll_id)
    response = Typhoeus.delete("#{CANVAS_SITE}/api/v1/courses/#{course_id}/enrollments/#{enroll_id}", body: {
      task: 'delete'
    },
      headers: {
        'Authorization' => "Bearer #{self.canvas_access_token}",
        'Content-Type' => 'application/x-www-form-urlencoded'
    })
    JSON.parse(response.body)
  end

end
