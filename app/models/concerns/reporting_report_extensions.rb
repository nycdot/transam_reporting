module ReportingReportExtensions
  extend ActiveSupport::Concern

  included do

    before_save :set_defaults

  end

  def set_defaults
    self.printable ||= false
    self.exportable ||= false
    true
  end
end