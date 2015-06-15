#!/usr/bin/env ruby
# coding:utf-8

a = Array.new
a.push "P1-KY-KE-GI-KI-OU-KI-GI-KE-KY"
a.push "P2 * -HI *  *  *  *  * -KA * "
a.push "P3-FU-FU-FU-FU-FU-FU-FU-FU-FU"
a.push "P4 *  *  *  *  *  *  *  *  * "
a.push "P5 *  *  *  *  *  *  *  *  * "
a.push "P6 *  *  *  *  *  *  *  *  * "
a.push "P7+FU+FU+FU+FU+FU+FU+FU+FU+FU"
a.push "P8 * +KA *  *  *  *  * +HI * "
a.push "P9+KY+KE+GI+KI+OU+KI+GI+KE+KY"

r = Array.new
h = Hash.new
a.each do |s|
  s =~ /^P(\d)/
  y = $1
  r.push(s.scan(/(\-..|\+..|\*)/))
  r.each_with_index do |element, i|
    puts i
#  locate = y.to_str
  end
end
