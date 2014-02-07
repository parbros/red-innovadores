module RemoteCourse

  CANVAS_SITE = 'http://lms.redinnovacion.org'  # The base-url for where we plan to retrieve data
  # CANVAS_SITE = 'http://localhost:3020'  # The base-url for where we plan to retrieve data
  
  # development access token
  # ACCESS_TOKEN = 'SKnDkEZuzp85ByfCGrkrIWrr15tHzPJJkkTRtaaWWgtaDLCCW37tUpELaUnbPWSz'
  
  #production access token
  ACCESS_TOKEN = '1XHwVBPAnk46sLXw1B8NBEzZBYD8HQAgtLMvBDCHQ6HAuqHNNWglkBb9BWqARDDW'
  

  def get_courses
    response = Typhoeus.get("#{CANVAS_SITE}/api/v1/courses?state=available", body: { 
      access_token: ACCESS_TOKEN
    })
    JSON.parse(response.body)
  end
  
  def enroll_to_course(course_id)
    response = Typhoeus.post("#{CANVAS_SITE}/api/v1/courses/#{course_id}/enrollments", body: {
      enrollment: {
        user_id: self.canvas_user_id,
        type: 'StudentEnrollment',
        enrollment_state: 'active',
        notify: true
      }
    },
      headers: {
        'Authorization' => "Bearer ACCESS_TOKEN",
        'Content-Type' => 'application/x-www-form-urlencoded'
    })
    JSON.parse(response.body)
  end

end
