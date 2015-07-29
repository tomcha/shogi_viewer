require 'minitest/autorun'
require 'logwriter'
require_relative '../app/lib/kifu'

class TesstKifu < Minitest::Test
  describe Kifu do
    before do 
      @my = Kifu.new
    end

    it 'テスト用yamlのパスを渡してyamlを生成した時、エラーが出ない' do
      @yamlpath = File.expand_path('../test.yaml', __FILE__)
      assert_silent{@my.create_yaml(@yamlpath)}
    end

    it '先手77歩を76へ移動' do
      @my.change_boad('+', 77, 76, 'FU')
      assert_equal '*', @my.boad[77]
      assert_equal '+FU', @my.boad[76]
    end

    it '後手33歩を34へ移動' do
      @my.change_boad('+', 77, 76, 'FU')
      @my.change_boad('-', 33, 34, 'FU')
      assert_equal '*', @my.boad[33]
      assert_equal '-FU', @my.boad[34]
    end

    it '先手駒取り88角を22へ移動し、相手の角を取る（先手持ち駒に角）' do
      @my.change_boad('+', 77, 76, 'FU')
      @my.change_boad('-', 33, 34, 'FU')
      @my.change_boad('+', 88, 22, 'KA')
      assert_equal '*', @my.boad[88]
      assert_equal '+KA', @my.boad[22]
      assert_equal 1, @my.boad['+00']['KA'].to_i
    end

    it '後手31銀を22へ移動し、相手の角を取る(後手持ち駒に角)' do
      @my.change_boad('+', 77, 76, 'FU')
      @my.change_boad('-', 33, 34, 'FU')
      @my.change_boad('+', 88, 22, 'KA')
      @my.change_boad('-', 31, 22, 'GI')
      assert_equal '*', @my.boad[31]
      assert_equal '-GI', @my.boad[22]
      assert_equal 1, @my.boad['-00']['KA'].to_i
    end

    it '先手駒打ち(88角打ち、先手の駒がなくなる)' do
      @my.change_boad('+', 77, 76, 'FU')
      @my.change_boad('-', 33, 34, 'FU')
      @my.change_boad('+', 88, 22, 'KA')
      @my.change_boad('-', 31, 22, 'GI')
      @my.change_boad('+', '00', 88, 'KA')
      assert_equal '+KA', @my.boad[88]
      assert_equal 0, @my.boad['+00']['KA'].to_i
    end

    it '先手駒打ち(33角打ち、後手の駒がなくなる)' do
      @my.change_boad('+', 77, 76, 'FU')
      @my.change_boad('-', 33, 34, 'FU')
      @my.change_boad('+', 88, 22, 'KA')
      @my.change_boad('-', 31, 22, 'GI')
      @my.change_boad('+', '00', 88, 'KA')
      @my.change_boad('-', '00', 33, 'KA')
      assert_equal '-KA', @my.boad[33]
      assert_equal 0, @my.boad['-00']['KA'].to_i
    end

  end
end
