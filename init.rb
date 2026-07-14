require 'redmine'

overrides_path = File.expand_path('../app/overrides', __FILE__)
Rails.application.paths['app/overrides'] ||= []
Rails.application.paths['app/overrides'] << overrides_path
Rails.autoloaders.main.ignore(overrides_path)

Redmine::Plugin.register :redmine_digest do
  name 'Redmine Digest Plugin'
  description 'This plugin enables you to send daily/weekly/monthly digests.'
  author 'Restream'
  version '1.1.0'
  url 'https://github.com/KrissXan/redmine_digest'

  requires_redmine version_or_higher: '2.2'
  requires_redmine_plugin :redmine__select2, version_or_higher: '1.0.1'

  permission :manage_digest_rules, { digest_rules: [:new, :create, :edit, :update] },
             public:  true,
             require: :loggedin
end

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'redmine_digest'

Dir.glob(File.join(overrides_path, '**', '*.rb')).each do |override_file|
  require override_file
end