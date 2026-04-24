# frozen_string_literal: true

class Role < ApplicationRecord
  belongs_to :resource, polymorphic: true, optional: true
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  scope :global, -> { where(resource_type: nil, resource_id: nil) }
  scope :for_class, ->(resource_class) { where(resource_type: resource_class, resource_id: nil) }
  scope :for_instance, ->(resource_instance) { where(resource: resource_instance) }

  scope :developer, -> { where(name: :developer) }
  scope :admin, -> { where(name: :admin) }
  scope :manager, -> { where(name: :manager) }
  scope :member, -> { where(name: :member) }
end
