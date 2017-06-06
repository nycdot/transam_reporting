module ReportFormatHelper
  def format_using_format(val, format)
    case format
    when :currency
      number_to_currency(val, format: '%u%nM', negative_format: '(%u%nM)')
    else
      # Note, current implementation uses rescue and is thus potentially inefficient.
      # Consider alterantives.
      format_as_general(val)
    end
  end
end