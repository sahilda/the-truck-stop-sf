# frozen_string_literal: true

require_relative './facebookConnector.rb'

class DataPull
  def initialize    
    make_days
    make_menu
  end

  def make_days
    @days = {1=>"MONDAY", 2=>"TUESDAY", 3=>"WEDNESDAY", 4=>"THURSDAY", 5=>"FRIDAY"}
  end

  def make_menu
    @menu = {
      'whisk on wheels' => 'http://www.sfwhisk.com/menu/',
      'the chairman' => 'http://www.hailthechairman.com/sf-menu',
      'koja kitchen' => 'http://www.kojakitchen.com/menu',
      'bonito poke' => 'http://www.bonitopoke.com/menu.html',
      'hiyaaa' => 'https://www.hiyaaa.net/menu',
      'curry up now' => 'http://www.curryupnow.com/truck-menu/',
      'spork & stix' => 'https://www.sporkandstix.com/menus',
      'drums and crumbs' => 'http://drumsandcrumbs.com/drums-and-crumbs-menus/retail',
      'steamin\' butger' => 'http://www.thesteaminburger.com/menu.html',
      'steamin\' burger' => 'http://www.thesteaminburger.com/menu.html',
      'don pablo truck' => 'http://www.donpablotrucksf.com/#menu',
      'phat thai' => 'http://phatthaisf.com/menu.html',
      'an the go' => 'https://twitter.com/anthegosf',
      'seoulful korean fried chicken' => 'https://www.seoulfulfc.com/menu',
      'ebbett\'s good to go' => 'https://ebbettsgoodtogo.com/',
      'mobowl' => 'http://www.eatmobowl.com/menu.html',
      'senor sisig' => 'http://www.senorsisig.com/#menu',
      'mayo and mustard' => 'http://www.mayomustard.com/menu',
      'sunrise deli' => 'http://www.sunrisedeli.net/menu.php',
      'mai thai kitchen' => 'http://www.maithaikitchen.com/our-menus---example.html',
      'cochinita bay area' => 'https://cochinitasf.com/menu',
      'country grill sf' => 'http://roadsidesf.com/#best-friends',
      'street meet' => 'http://www.streetmeettruck.ca/menu/',
      'me so hungry sf' => 'http://mesohungrytruck.com/',
      'casablanca best food' => 'http://casablancamoroccanfood.com/foodtruck.html',
    }
  end
end