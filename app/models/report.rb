# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentions, foreign_key: 'mentioning_id', dependent: :destroy
  has_many :mentioning_reports, through: :mentions, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mention(other_report)
    mentions.create!(mentioned_id: other_report.id)
  end

  def mention_destroy(other_report)
    mentions.find_by(mentioned_id: other_report.id).destroy
  end
end
