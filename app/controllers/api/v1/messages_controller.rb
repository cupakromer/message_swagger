# frozen_string_literal: true

class API::V1::MessagesController < API::V1::ResourceController
  def index
    munge_param :since, default: 30, max: 30
    @messages = AppContext.current_user
                          .messages
                          .where(created_at: (params[:since].days.ago...))
                          .includes(:depot)
                          .order(id: :desc)
                          .limit(params[:limit])
  end

  def show
    @message = AppContext.current_user.messages.find(params[:id])
  end

  def create
    head :method_not_allowed

    # TODO: Flush this out with the depot indirection
    # @message = AppContext.current_user.authored_messages.new

    # if @message.save
    #   render :show, status: :created, location: @message
    # else
    #   render json: @message.errors, status: :unprocessable_entity
    # end
  end

  def destroy
    # TODO: Decide how recipients can stop seeing messages
    message = AppContext.current_user.authored_messages.find_by(id: params[:id])
    message&.destroy!

    head :no_content
  end

private

  # Only allow a list of trusted parameters through.
  def message_params
    _submitted_param = params.require(:data).permit(:user_id, :content)

    # TODO: Look up the user and check if they have a direct depot otherwise raise an error for a
    # TODO: 400 response
  end
end
