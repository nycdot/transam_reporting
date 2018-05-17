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
end