module ReportFormatHelper

  # return appropriate alignment class for given format
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

  # Some textual formatting of exported data
  def format_for_export(row, formats)
    formatted_row = []
    row.zip(formats).each do |val, format|
      formatted = val
      if format == :boolean
        formatted = val ? 'Yes' : ''
      end
      formatted_row << formatted
    end
    formatted_row
  end
end