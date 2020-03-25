class RelevantContentController < ApplicationController
  def index
    content = RelevantContentFacade.new(params[:keywords])
    render json: RelevantContentSerializer.new(content)
  end
end
