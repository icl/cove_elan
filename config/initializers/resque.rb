require 'ar_after_transaction'
require 'resque'
require 'template_identifier'

Resque.inline = true

Resque.class_eval do
  class << self
    alias_method :enqueue_without_transaction, :enqueue
    def enqueue(*args)
      ActiveRecord::Base.after_transaction do
        enqueue_without_transaction(*args)
      end
    end
  end
end
