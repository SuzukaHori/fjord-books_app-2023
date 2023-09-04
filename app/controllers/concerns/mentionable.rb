# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern

  def create_mention(model, text)
    return unless text.include?(base_url)

    mentioned_ids = text.scan(/#{base_url}(\d+)/).flatten
    mentioned_ids.each do |mentioned_id|
      mention = model.active_mentions.new(mentioned_id:)
      mention.save!
    end
  end

  def mentions_are_unique?(text)
    mentioned_ids = create_id_array(text)
    mentioned_ids.length == mentioned_ids.uniq.length
  end

  private

  def base_url
    "http://localhost:3000/reports/"
  end

  def create_id_array(text)
    text.scan(/#{base_url}(\d+)/).flatten
  end
end
