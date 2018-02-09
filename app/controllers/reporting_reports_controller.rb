class ReportingReportsController < ReportsController

  before_filter :get_report, :only => [:show, :load, :details, :export_data]

  # Injects pdf and csv formats.
  # handle_show is a protected method of ReportController that sets up the @report_instance variable.
  
  def show
    handle_show do
      @actions = @report_instance.try(:get_actions)
      
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

  def details
    @data = @report.class_name.constantize.get_detail_data(@organization_list, params)
    @key = params[:key]
    @details_view = params[:view]
    render 'reports/report_details'
  end

  def export_data
    @data = @report.class_name.constantize.get_underlying_data(@organization_list, params)

    sanitized_report_name = @report.to_s.parameterize('_')

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment;filename=#{sanitized_report_name}.csv"
        render template: "reports/show.csv.haml"
      end
    end

  end
  
  def report_pdf_template(report_name)
    render_to_string(pdf: "#{report_name}", template: "reports/show", orientation: 'Landscape',
                     header: { right: '[page] of [topage]' })
  end
end