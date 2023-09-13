# frozen_string_literal: true

class Report < ApplicationRecord
  include Mentionable
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_references, class_name: 'Mention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning
  has_many :mentioning_reports, through: :mentioning_references, source: :mentioned

  has_many :mentioned_references, class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned
  has_many :mentioned_reports, through: :mentioned_references, source: :mentioning

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
    return if content.exclude?(Mentionable::BASE_URL)

    mentioned_ids = extract_ids_from_content(content)
    return if mentioned_ids.length == mentioned_ids.uniq.length

    errors.add(:content, I18n.t('activerecord.errors.messages.link_is_not_unique', model: Report.model_name.human))
  end

  def update_mentions!
    mentioning_references.destroy_all
    create_mentions(self)
  end
end
