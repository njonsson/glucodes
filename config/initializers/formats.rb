Date::DATE_FORMATS[:html] = '<abbr title="%A">%a</abbr> %m/%d/%Y'
Time::DATE_FORMATS[:html] = lambda { |time|
  ante_post = (time.hour < 12) ? 'ante' : 'post'
  am_pm = "<abbr title=\"#{ante_post} meridiem\">#{ante_post[0..0]}.m.</abbr>"
  time.strftime "#{Date::DATE_FORMATS[:html]} %I:%M #{am_pm}"
}
