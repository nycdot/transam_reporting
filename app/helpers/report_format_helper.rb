module ReportFormatHelper
  def format_using_format(val, format)
    case format
    when :currencyM
      number_to_currency(val, format: '%u%nM', negative_format: '(%u%nM)')
    when :currency
      format_as_currency(val)
    when :fiscal_year
      format_as_fiscal_year(val)
    when :integer
      format_as_integer(val)
    when :string
      val
    when :checkbox
      format_as_checkbox(val)
    when :boolean
      format_as_boolean(val)
    else
      # Note, current implementation uses rescue and is thus potentially inefficient.
      # Consider alterantives.
      format_as_general(val)
    end
  end

  def current_url(new_params)
    url_for params: params.merge(new_params)
  end
end