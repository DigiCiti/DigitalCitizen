class UpdateCongressJob < ApplicationJob
  queue_as :default

  # more research is needed to setup the job for updating congress member data
  # ...from the propublica api once a day instead of making a call for each
  # ...page load etc
  # the "whenever" gem is supposedly part of the common solution
  # official docs make a few suggestions
  # consider Heroku guides that address jobs over their server
  # for now, this will be taken care of in the seed file

  def perform(*args)
    # Do something later
  end
end
