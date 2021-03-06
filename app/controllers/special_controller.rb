class SpecialController < ApplicationController
	def index
		@search_results = search_video
	end

	private

	def check_if_logged_in?
		redirect_to sign_up_path unless signed_in?
	end

	def get_service
    	client = Google::APIClient.new(
	    :key => ENV['YOUTUBE_DEVELOPER_KEY'],
		    :authorization => nil,
		    :application_name => $PROGRAM_NAME,
		    :application_version => '1.0.0'
		  )
	    youtube = client.discovered_api(ENV['YOUTUBE_API_SERVICE_NAME'], ENV['YOUTUBE_API_VERSION'])

	    return client, youtube
	end

	def search_video
		opts = Trollop::options do
		    opt :q, 'Search term', :type => String, :default => 'cats'
		    opt :max_results, 'Max results', :type => :int, :default => 5
		  end

	    client, youtube = get_service

		begin
		# Call the search.list method to retrieve results matching the specified
		# query term.
			search_response = client.execute!(
			  :api_method => youtube.search.list,
			  :parameters => {
			  	:order => 'relevance',
			  	:order => 'date',
			    :part => 'snippet',
			  	:q => 'funny cats',
			    :maxResults => opts[:max_results]
			  }
			)

			search_response.data.items
	    rescue Google::APIClient::TransmissionError => e
			puts e.result.body
			[]
		end
	end
end
