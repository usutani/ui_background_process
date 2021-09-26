class Convert < ApplicationRecord
  RELOAD_INTERVAL_MARGIN = 2.seconds

  enum status: {
    waiting: 0,
    validating: 1,
    converting: 2,
    succeeded: 3,
    failed: 4
  }

  has_one_attached :in_file
  has_one_attached :out_file
  validates :in_file, presence: true

  scope :running, -> { where(status: [:waiting, :validating, :converting]) }
  scope :need_to_notify, -> { where('updated_at >= ?', Time.zone.now - RELOAD_INTERVAL_MARGIN) }

  def self.need_to_reload?
    running.exists?
  end

  def status_summary
    "#{id}:#{status}"
  end
end
