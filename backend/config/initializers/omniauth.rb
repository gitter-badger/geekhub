Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'dbb7ca0fc0f9a64ddc19', '7fb76d7b4872e7f004233a5f9ffcf08989366fb0', scope: 'email,profile'
end
