class CategoriesController < BaseFrontendController
  include SchemaDotOrg
  def index
    # @categories already initialized at collect_categories method of BaseFrontendController

    determine_page
    @page_meta = @current_page || OpenStruct.new(title: 'Categories')
    add_breadcrumb 'Categories', nil
  end

  def show
    @events = []
    @structured_data = []
    @category, needs_redirect = find_by_slug_with_fallback Category, params[:id]
    if needs_redirect
      redirect_to category_path(@category.slug), status: :moved_permanently
      return
    end

    @competitions = @category.competitions.order(name: :asc)
    if @competitions.count > 0
      # for the filter works
      @competitions_venues = Venue.joins(events: [:competition]).
                                   where('(events.start_time >= ? OR events.start_time IS NULL)', DateTime.now).
                                   where(competitions: { id: @competitions.pluck(:id) }).
                                   group(:id)
    else
      @players = @category.players.order(name: :asc)
      if @players.count > 0
        # for the filter works
        @players_venues = Venue.joins(events: [:players]).
                                where('(events.start_time >= ? OR events.start_time IS NULL)', DateTime.now).
                                where(players: { id: @players.pluck(:id) }).
                                group(:id)
      else
        @events = @category.events.order(start_time: :asc)
        @events, @event_count_before_filtration = apply_day_filter_to_events @events
      end
    end

    @page_meta = @category

    if @events.any?
      json_data = @events.map{|evt| evt.json_structured_data}
      json_data.each do |dt|
        @structured_data << JSON.parse(dt.to_json_as_root)
      end
    end


    add_common_breadcrumbs! @category
  end

end
