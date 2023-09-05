# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern

  def create_mention(model)
    return unless model.content.include?(base_url)

    mentioned_ids = extract_ids_from_content(model.content)
    mentioned_ids.each do |mentioned_id|
      mention = model.active_mentions.new(mentioned_id:)
      mention.save!
    end
  end

  def mentions_are_unique?(content)
    mentioned_ids = extract_ids_from_content(content)
    mentioned_ids.length == mentioned_ids.uniq.length
  end

  private

  def base_url
    "http://localhost:3000/reports/"
  end

  def extract_ids_from_content(content)
    content.scan(/#{base_url}(\d+)/).flatten
  end
end
