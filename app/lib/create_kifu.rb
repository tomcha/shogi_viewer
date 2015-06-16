#!/usr/bin/env ruby
#coding:utf-8
require 'yaml'

r = Array.new
r[0] = "P1-KY-KE-GI-KI-OU-KI-GI-KE-KY"
r[1] = "P2 * -HI *  *  *  *  * -KA * "
r[2] = "P3-FU-FU-FU-FU-FU-FU-FU-FU-FU"
r[3] = "P4 *  *  *  *  *  *  *  *  * "
r[4] = "P5 *  *  *  *  *  *  *  *  * "
r[5] = "P6 *  *  *  *  *  *  *  *  * "
r[6] = "P7+FU+FU+FU+FU+FU+FU+FU+FU+FU"
r[7] = "P8 * +KA *  *  *  *  * +HI * "
r[8] = "P9+KY+KE+GI+KI+OU+KI+GI+KE+KY"

#db = YAML::Store.new('../../data/kifu.yaml')
File.open('../../public/data/kifu.data', 'w') do |file|
  h = Hash.new
  y = 1
  r.each do |s|
    a = (s.scan(/(\-..|\+..|\*)/).reverse).flatten
    a.each_with_index do |item, i|
      locate = ((i + 1).to_s + y.to_s).to_i
      h[locate] = item
    end
    y += 1
  end
  file.puts h.to_yaml
end
