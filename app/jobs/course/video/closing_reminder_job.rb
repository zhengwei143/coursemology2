class Course::Video::ClosingReminderJob < ApplicationJob
  include TrackableJob

  rescue_from(ActiveJob::DeserializationError) do |_|
    # Prevent the job from retrying due to deleted records
  end

  protected

  def perform_tracked(user, video, end_at)
    instance = Course.unscoped { video.course.instance }
    ActsAsTenant.with_tenant(instance) do
      Course::Video::ReminderService.closing_reminder(user, video, end_at)
    end
  end
end
