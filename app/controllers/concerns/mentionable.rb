# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern
  BASE_URL = 'http://localhost:3000/reports/'

  def create_mention(model)
    return if model.content.exclude?(BASE_URL)

    mentioned_ids = extract_ids_from_content(model.content)
    mentioned_ids.each do |mentioned_id|
      mention = model.mentioning_references.new(mentioned_id:)
      mention.save!
    end
  end

  private

  def extract_ids_from_content(content)
    content.scan(/#{BASE_URL}(\d+)/).flatten
  end
end
