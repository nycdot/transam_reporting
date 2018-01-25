module ReportFormatHelper

  def table_class_from_format(format)
    case format
    when :currencyM, :currency, :integer, :boolean
      'right'
    when :fiscal_year
      'center'
    when :string
      'left'
    else
      'left'
    end
  end

  def current_url(new_params)
    url_for params: params.merge(new_params)
  end
end