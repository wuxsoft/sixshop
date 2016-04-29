class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_validation :require_atlest_one_role
  def require_atlest_one_role
    if self.role_ids.size == 0
      self.errors.add(:role_ids, 'is required.')
    end
  end

  def root?
    id == 1
  end
end
