# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  def developer? = roles.developer.global.exists?
  def admin? = roles.admin.global.exists?
  def campaign_manager? = roles.manager.for_class("Campaign").exists?
  def member_of?(resource) = roles.member.for_instance(resource).exists?
  def manager_of?(resource) = roles.manager.for_instance(resource).exists?
end
