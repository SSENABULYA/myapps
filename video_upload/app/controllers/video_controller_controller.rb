class VideoControllerController < ApplicationController
  def index
  	@videos = Video.all
  end

  def new
  	@pre_upload_info = {}
  end

  def get_upload_token
  temp_params = { title: params[:title], description: params[:description], category: 'Education',
                  keywords: [] }
 
  if current_user
	    codefellowship = YouTubeIt::OAuth2Client.new(client_access_token: current_user.token,
	                                          dev_key: ENV['AIzaSyDVtfCp87NQnBgSlk0y8J0X7moqSTKvaCQ'])
	 
	    upload_info = codefellowship.upload_token(temp_params, get_video_uid_url)
	 
	    render json: {token: upload_info[:token], url: upload_info[:url]}
	  else
	    render json: {error_type: 'Not authorized.', status: :unprocessable_entity}
	  end
	end

  	def get_video_uid
		  video_uid = params[:id]
		  v = current_user.videos.build(uid: video_uid)
		  codefellowship = YouTubeIt::OAuth2Client.new(dev_key: ENV['AIzaSyDVtfCp87NQnBgSlk0y8J0X7moqSTKvaCQ'])
		  yt_video = codefellowship.video_by(video_uid)
		  v.title = yt_video.title
		  v.description = yt_video.description
		  v.save
		  flash[:success] = 'Thanks for sharing your video!'
		  redirect_to root_url
	end

end
