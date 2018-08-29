# frozen_string_literal: true

require_relative './facebookConnector.rb'

class DataPull
  def initialize
    @@days ||= make_days
    @@menu ||= make_menu
  end

  def make_days
    { 1 => 'MONDAY', 2 => 'TUESDAY', 3 => 'WEDNESDAY', 4 => 'THURSDAY', 5 => 'FRIDAY' }
  end

  def make_menu
    menu = {
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
      'roli roti gourmet rotisserie' => 'https://www.roliroti.com/food/',
      'wokitchentruck' => 'https://wokitchentruck.com/index-2.html',
      'liberty cheesesteak' => 'http://www.lcfoodtruck.com/',
      'lamas peruvian food' => 'https://www.lamasperuvianfood.com/menu',
      'Kabob Trolley' => 'http://www.kabobtrolley.com/halal-food-in-san-francisco.html',
      'Señor Sisig' => 'http://www.senorsisig.com/#menu',
      'Lady Saigon' => 'https://www.yelp.com/biz/lady-saigon-san-francisco',
      'The Steamin\' Burger' => 'http://www.thesteaminburger.com/menu.html',
      'Little Red Riding Truck' => 'https://www.littleredridingtrucksf.com/truck-menu',
      'Me So Hungry Too' => 'http://mesohungrytruck.com/',
    }
    menu.to_a.map { |pair| [pair.first.downcase, pair.last] }.to_h
  end
end
