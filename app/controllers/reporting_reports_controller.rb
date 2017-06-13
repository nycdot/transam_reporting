class ReportingReportsController < ReportsController
  # Injects pdf and csv formats.
  # handle_show is a protected method of ReportController that sets up the @report variable.
  
  def show
    handle_show do
      # Get the report instance to find "Actions"
      report_instance = @report.class_name.constantize.new(params)
      @actions = report_instance.try(:get_actions)
      
      sanitized_report_name = @report.to_s.parameterize('_')

      respond_to do |format|
        format.html
        format.xls do
          response.headers['Content-Disposition'] = "attachment; filename=#{sanitized_report_name}.xls"
        end
        format.pdf do
          send_data report_pdf_template(sanitized_report_name), type: 'application/pdf', disposition: 'inline'
        end
        format.csv do 
          headers['Content-Disposition'] = "attachment;filename=#{sanitized_report_name}.csv"
          render template: "reports/show.csv.haml"
        end
      end
    end
  end

  def report_pdf_template(report_name)
    render_to_string(pdf: "#{report_name}", template: "reports/show")
  end
end