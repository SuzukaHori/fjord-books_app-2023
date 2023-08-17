# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :postcode, format: { with: /\A\d{3}-?\d{4}\z/, message: :incorrect_postcode }, if: :postcode?
end
