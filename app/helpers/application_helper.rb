module ApplicationHelper
  def time_ago_in_words(time)
    distance = Time.current - time
    "#{distance.to_i} seconds"
  end
end
