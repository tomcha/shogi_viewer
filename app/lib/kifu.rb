require 'logwriter'
class Kifu
  attr_reader :boad
  attr_reader :lw

  def initialize
    default_boad = Array.new
    default_boad[0] = "P1-KY-KE-GI-KI-OU-KI-GI-KE-KY"
    default_boad[1] = "P2 * -HI *  *  *  *  * -KA * "
    default_boad[2] = "P3-FU-FU-FU-FU-FU-FU-FU-FU-FU"
    default_boad[3] = "P4 *  *  *  *  *  *  *  *  * "
    default_boad[4] = "P5 *  *  *  *  *  *  *  *  * "
    default_boad[5] = "P6 *  *  *  *  *  *  *  *  * "
    default_boad[6] = "P7+FU+FU+FU+FU+FU+FU+FU+FU+FU"
    default_boad[7] = "P8 * +KA *  *  *  *  * +HI * "
    default_boad[8] = "P9+KY+KE+GI+KI+OU+KI+GI+KE+KY"

    @boad = Hash.new
    @boad['+00'] = Hash.new
    @boad['-00'] = Hash.new
#    @lw = Logwriter::Logger.new('./kifu.log')

    y = 1
    default_boad.each do |s|
      a = (s.scan(/(\-..|\+..|\*)/).reverse).flatten
      a.each_with_index do |item, i|
        locate = ((i + 1).to_s + y.to_s).to_i
        @boad[locate] = item
      end
      y += 1
    end
#    @lw.v @boad
  end

  def create_yaml(kifu_file)
    #    '../../public/data/kifu.data'
    require 'yaml'
    #fileの有無チェック
    File.open(kifu_file, 'w') do |file|
      file.puts @boad.to_yaml
    end
  end
  #db = YAML::Store.new('../../data/kifu.yaml')
  
  def change_boad(teban, before_place, after_place, unit)
#    @lw.v [teban, before_place, after_place, unit], 'cahnge_boad引数'
    if( before_place == 0)
#      @lw.v before_place, 'before_place_value'
#      @lw.v unit, 'before_unit_name:'
#      @lw.v @boad
      @boad["#{teban}00"][unit] -= 1
#      @lw.f 1
#      @lw.v @boad
    end

    if(@boad[after_place] != '*')
#      @lw.v [after_place, @boad[after_place]], 'after_unit_name:'
      take_unit(after_place)
    end
    
    @boad[after_place] = teban + unit
    @boad[before_place] = '*'
  end

  def take_unit(after_place)
    @boad[after_place] =~ /^(\+|\-)(..)$/

    case $2
    when 'TO'
      unit = 'FU'
    when 'NY'
      unit = 'KY'
    when 'NK'
      unit = 'KE'
    when 'NG'
      unit = 'GI'
    when 'UM'
      unit = 'KA'
    when 'RY'
      unit = 'HI'
    else
      unit = $2
   end

    if($1 == '-')
      @boad['+00'][unit] = @boad['+00'][unit].to_i + 1 || 1
    else
      @boad['-00'][unit] = @boad['-00'][unit].to_i + 1 || 1
    end

  end
end
