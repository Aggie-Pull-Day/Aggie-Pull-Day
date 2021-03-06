class Group < ApplicationRecord
  has_many :users

  def classification
    members = User.where(group_id: id)
    group_size = members.length
    num_grads = members.all.select { |m| m.get_classification == 'U5' }.length
    num_seniors = members.all.select { |m| m.get_classification == 'U4' }.length
    num_juniors = members.all.select { |m| m.get_classification == 'U3' }.length
    num_sophomores = members.all.select { |m| m.get_classification == 'U2' }.length

    if num_grads + num_seniors >= group_size / 2.0
      4
    elsif num_juniors >= group_size / 2.0
      3
    elsif num_sophomores >= group_size / 2.0
      2
    else
      1
    end
  end

  def dropdown_options
    members = User.where(group_id: id)
    members.collect do |member|
      [member.get_email, member.get_email]
    end
  end
end
