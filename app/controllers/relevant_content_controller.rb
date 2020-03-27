class RelevantContentController < ApplicationController
  def index
    content = RelevantContentFacade.new(params)
    render json: RelevantContentSerializer.new(content)
  end
end
