# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#


class User < ActiveRecord::Base


  has_many :enrollments,
          primary_key: :id,
          foreign_key: :student_id,
          class_name: :Enrollment

  has_many :courses_taught,
          primary_key: :id,
          foreign_key: :instructor_id,
          class_name: :Course



#through
  has_many :enrolled_courses,
    through: :enrollments,
    source: :courses



end
