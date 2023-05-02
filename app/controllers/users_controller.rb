class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
    @follow_request = FollowRequest.where(sender_id: current_user.id).where(recipient_id: @user.id).first
    @follow_request_reverse = FollowRequest.where(sender_id: @user.id).where(recipient_id: current_user.id).first
  end

  def followers
    @user = User.find_by!(username: params.fetch(:username))
  end

  def following
    @user = User.find_by!(username: params.fetch(:username))
  end

  def pending
    @user = User.find_by!(username: params.fetch(:username))
  end
end
