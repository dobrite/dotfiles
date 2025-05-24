#!/usr/bin/env ruby

# Usage: timey [timestamp]
#
# Examples:
#
#     → timey
#     UTC: 2025-04-02 15:50:58 UTC
#     PDT: 2025-04-02 08:50:58 -0700
#
#     → timey '2025-04-02 15:52:02 UTC'
#     UTC: 2025-04-02 15:52:02 UTC
#     PDT: 2025-04-02 08:52:02 -0700
#
#     → timey '2025-04-02T15:52:02Z'
#     UTC: 2025-04-02 15:52:02 UTC
#     PDT: 2025-04-02 08:52:02 -0700
#
#     → timey '10:52'
#     UTC: 2025-04-02 15:52:00 UTC
#     PDT: 2025-04-02 08:52:00 -0700
#
# ~stolen~ modified from: @seven1m <3

require 'time'

timestamp = ARGV.first || Time.now.to_s

if timestamp.end_with?('Z') || timestamp.end_with?('UTC')
  utc_time = Time.parse(timestamp)
  local = utc_time.getlocal
  dst = utc_time.getlocal.dst?
else
  local = Time.parse(timestamp)
  utc_time = local.dup.utc
  dst = local.dst?
end

puts "UTC: #{utc_time}"

ca_offset = dst ? -7 : -8
ca_time = utc_time.getlocal("%+03d:00" % ca_offset)
puts "#{dst ? 'PDT' : 'PST'}: #{ca_time}"
