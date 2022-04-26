class Group < ApplicationRecord
  has_many :users

  def classification
    members = User.where(group_id: id)
    group_size = members.length
    num_grads = members.where(classification: 'U5').length
    num_seniors = members.where(classification: 'U4').length
    num_juniors = members.where(classification: 'U3').length
    num_sophomores = members.where(classification: 'U2').length

    if num_grads + num_seniors >= group_size / 2.0
      'U4'
    elsif num_juniors >= group_size / 2.0
      'U3'
    elsif num_sophomores >= group_size / 2.0
      'U2'
    else
      'U1'
    end
  end

  def dropdown_options
    members = User.where(group_id: id)
    members.collect do |member|
      [member[:email], member[:email]]
    end
  end
end
