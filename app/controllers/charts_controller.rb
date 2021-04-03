#The existing reports controller is simultaneously too hardwired and too DB dependent.
#This is a simple controler to render simple pages without any DB editing for following convoluted and undocumented conventions.
class ChartsController < OrganizationAwareController

  add_breadcrumb 'Home', :root_path

  def asset_update_report
    add_breadcrumb 'Usage Charts'

    #TODO: Reporting is not dependent on Transit. Transit-Specific code should probably move to the transit engine, but at the same time, this needs to go into the reporting dropdown.

    # Hack: Time is up to turn this in.
    unless current_user.has_role? :admin 
      return 
    end
  
    @start_month = (chart_params[:start_month] || Time.now.month).to_i
    @start_year = (chart_params[:start_year] || (Time.now - 3.years).year).to_i
    @end_month = (chart_params[:end_month] || Time.now.month).to_i
    @end_year = (chart_params[:end_year] || Time.now.year).to_i

    starting = DateTime.new(@start_year,@start_month,1,1,1,1).beginning_of_month
    ending = [DateTime.new(@end_year,@end_month,1,1,1,1).end_of_month, starting.end_of_month].max 

    #Asset Type Counts
    @typed_counts = AssetEvent.where(created_at: starting..ending).group(:asset_event_type).count.map{ |a| [a[0].name, a[1]]}
    
    #MONTHLY COUNTS
    @monthly_counts = []
    current_month = starting 
    while(current_month < ending)
      @monthly_counts << [current_month.strftime('%m/%y'), AssetEvent.where(event_date: current_month.beginning_of_month..current_month.end_of_month).count]
      current_month += 1.months 
    end

    #MONTHLY TYPED COUNTS
    @monthly_typed_counts = []
    AssetEventType.all.each do |aet|
      if AssetEvent.where(asset_event_type: aet).where(event_date: starting..ending).count > 0 
        typed_counts = []
        #typed_counts << ["#{m}/#{y}", AssetEvent.where(asset_event_type: aet, event_date: dt.beginning_of_month..dt.end_of_month).count]
        current_month = starting 
        while(current_month < ending)
          typed_counts << [current_month.strftime('%m/%y'), AssetEvent.where(asset_event_type: aet).where(event_date: current_month.beginning_of_month..current_month.end_of_month).count]
          current_month += 1
        end
        @monthly_typed_counts << {name: aet.name, data: typed_counts}
      end
    end

    ## Asset Count by Org
    @org_asset_counts = []
    Organization.all.each do |org|
      org_count = TransamAsset.where(organization: org).where(created_at: starting..ending).count 
      @org_asset_counts << [org.short_name, org_count]
    end

  end

  private 

  def chart_params
    params.permit(:start_year, :start_month, :end_year, :end_month)
  end

end