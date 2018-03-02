# coding: utf-8
require File.dirname(__FILE__) + "/party"
require File.dirname(__FILE__) + "/dhondt"

puts "比例近畿ブロック"
party_array = []
party_array.push(Party.new("自由民主党",   2586424))
party_array.push(Party.new("公明党"      ,1164995))
party_array.push(Party.new("立憲民主党"  , 1335360))
party_array.push(Party.new("希望の党"    ,  913860))
party_array.push(Party.new("日本共産党"  ,  786158))
party_array.push(Party.new("日本維新の会", 1544821))
party_array.push(Party.new("社会民主党"  ,   78702))
party_array.push(Party.new("幸福実現党"  ,   36774))

Dhondt.count_seat(party_array, 28)

party_array.each do |party|
  puts "#{party.name}の獲得議席数は#{party.seat_count}です。"
end


