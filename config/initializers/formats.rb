DAY_OF_WEEK_FORMAT = '<abbr title="%A">%a</abbr>'

def month_day_year_format(date_or_time)
  "#{date_or_time.month}/%d/%Y"
end

Date::DATE_FORMATS[:html] = lambda { |date|
  date.strftime "#{DAY_OF_WEEK_FORMAT} #{month_day_year_format date}"
}
Time::DATE_FORMATS[:html] = lambda { |time|
  ante_post = (time.hour < 12) ? 'ante' : 'post'
  am_pm = "<abbr title=\"#{ante_post} meridiem\">#{ante_post[0..0]}.m.</abbr>"
  time.strftime "#{DAY_OF_WEEK_FORMAT} #{month_day_year_format time} %I:%M #{am_pm}"
}
Time::DATE_FORMATS[:csv] = '%Y-%m-%d %H:%M'
