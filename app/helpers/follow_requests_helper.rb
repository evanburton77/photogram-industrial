module FollowRequestsHelper
  def follow_button_text(follow_request)
    follow_button_text = ""
    if follow_request.nil?
      follow_button_text = "Follow"
    elsif follow_request.status == "accepted"
      follow_button_text = "Un-Follow"
    elsif follow_request.status == "pending"
      follow_button_text = "Un-Request"
    else
      follow_button_text = "Un-Request"
    end

    follow_button_text
  end
end
