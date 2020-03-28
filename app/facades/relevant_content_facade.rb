class RelevantContentFacade
  attr_reader :id, :count, :params

  def initialize(params)
    @id = nil
    @count = params[:count] || 50
    @params = params
  end

  def videos
    youtube_service.videos[:items].map do |data|
      YoutubeVideo.new(data)
    end.sample(count.to_i)
  end

  private

  def youtube_service
    @service = YoutubeService.new(params)
  end
end
