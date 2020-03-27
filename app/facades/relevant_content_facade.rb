class RelevantContentFacade
  attr_reader :id, :count, :keywords

  def initialize(params)
    @id = nil
    @count = params[:count].to_i
    @keywords = params[:keywords]
  end

  def videos
    youtube_service.videos.map do |data|
      YoutubeVideo.new(data)
    end.sample(count)
  end

  private

  def youtube_service
    @service = YoutubeService.new(keywords)
  end
end
