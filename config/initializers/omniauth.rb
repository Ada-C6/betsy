Rails.application.config.middleware.use OmniAuth::Builder do
	# binding.pry
	provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end