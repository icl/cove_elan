module ApplicationHelper
  #thanks http://stackoverflow.com/questions/770876/how-do-i-add-gravatar-identicons-into-ruby-on-rails
  def gravatar_for email, options = {}
    options = {:alt => "Avatar for #{email}", :class => 'avatar'}.merge! options
    id = Digest::MD5::hexdigest email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '.jpg?s=' + options[:size].to_s
    options.delete :size
    image_tag url, options
  end
end
