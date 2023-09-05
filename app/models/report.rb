# frozen_string_literal: true

class Report < ApplicationRecord
  include Mentionable
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned

  has_many :passive_mentions,  class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true
  validate :content, :report_url_must_be_unique

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def report_url_must_be_unique
    return if content.exclude?(base_url)
    return if mentions_are_unique?(content)

    errors.add(:content, I18n.t('activerecord.errors.messages.link_is_not_unique', model: Report.model_name.human))
  end
end
