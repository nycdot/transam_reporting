class ReportingReportsController < ReportsController
  # Injects pdf and csv formats.
  # handle_show is a projected method of ReportController that sets up the @report variable.
  
  def show
    handle_show do
      respond_to do |format|
        format.html
        format.xls do
          sanitized_report_name = @report.name.gsub(" ", "_").underscore
          response.headers['Content-Disposition'] = "attachment; filename=#{@organization.short_name}_#{sanitized_report_name}.xls"
        end
        format.pdf do
          send_data report_pdf_template, type: 'application/pdf', disposition: 'inline'
        end
      end
    end
  end

  def report_pdf_template
    render_to_string(pdf: "#{@report.view_name}", template: "reports/show")
  end
end