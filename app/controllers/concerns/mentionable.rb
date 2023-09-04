# frozen_string_literal: true

module Mentionable
  extend ActiveSupport::Concern
  REPORT_URL = "http://localhost:3000/reports/"

  def create_report_id_array(text)
    text.scan(/#{REPORT_URL}(\d)/).map { |ids| ids[0] }
  end

  def create_mention(report)
    return unless report.content.include?('http://localhost:3000/reports/')

    mentioned_report_ids = create_report_id_array(report.content)
    mentioned_report_ids.each do |mentioned_id|
      mention = report.active_mentions.new(mentioned_id:)
      mention.save!
    end
  end
end
