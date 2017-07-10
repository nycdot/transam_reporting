module ReportFormatHelper
  def format_using_format(val, format)
    case format
    when :currencyM
      number_to_currency(val, format: '%u%nM', negative_format: '(%u%nM)')
    when :currency
      format_as_currency(val)
    when :fiscal_year
      format_as_fiscal_year(val.to_i) unless val.nil?
    when :integer
      format_as_integer(val)
    when :string
      val
    when :checkbox
      format_as_checkbox(val)
    when :boolean
      # Check for 1/0 val as well as true/false given direct query clause
      format_as_boolean(val == 0 ? false : val)
    else
      # Note, current implementation uses rescue and is thus potentially inefficient.
      # Consider alterantives.
      format_as_general(val)
    end
  end

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