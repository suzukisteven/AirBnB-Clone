OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '150735641108-6on46k9cvfg10857gdas3j0ukjfnk8rn.apps.googleusercontent.com', 'PKiRzZEbN3FHqLwEjvWkQLIY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
