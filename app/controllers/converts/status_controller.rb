class Converts::StatusController < ApplicationController
  def index
    @need_to_reload = Convert.need_to_reload?
    @converts = Convert.running.or(Convert.need_to_notify)
  end
end
