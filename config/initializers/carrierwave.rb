CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIY2DAHBFK2LMKR7A',       # required unless using use_iam_profile
    aws_secret_access_key: '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',  # required unless using use_iam_profile
    use_iam_profile:       true,                         # optional, defaults to false
    region:                'us-east-2'                  # optional, defaults to 'us-east-1'

  }
  config.fog_directory  = 'sleezy-app' # required
  config.fog_public     = false  # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end