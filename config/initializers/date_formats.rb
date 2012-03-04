Time::DATE_FORMATS.merge!(
:db => '%Y-%m-%d',
:standard => '%Y-%m-%d',
:default => '%Y-%m-%d',
:standard_time => '%Y-%m-%d %H:%M'
)

Date::DATE_FORMATS[:default]='%Y-%m-%d'
Date::DATE_FORMATS[:standard]='%Y-%m-%d'
Date::DATE_FORMATS[:standard_time]='%Y-%m-%d %H:%M'
