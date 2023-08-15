# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :icon, resize_to_fill: [100, 100]
  end

  validate :avatar_type

  private

  def avatar_type
    return unless avatar.attached?

    errors.add(:avatar, :incorrect_file_formats, file_formats: 'jpg・png・gif') unless avatar.image?
  end
end
