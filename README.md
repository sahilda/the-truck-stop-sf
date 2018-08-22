# The Truck Stop SF plugin

A simple app that responds to Slack commands with today's menu for the Truck Stop SF http://www.truckstopsf.com/. 

#### TODOs:
* Extend it to work on all Slack rooms
* Make it work with HipChat
* Modify the message to add line breaks between trucks **(done)**
* Modify the script to check current SF time instead of system time **(set to PST, so no daylight savings is taken into account, but good enough)**
* Enhance the message to add links to each truck's website **(done)**
* Handle the case where their website is not updated with this week's menu **(done)**

#### Run the app by:
1. Setting up environment.rb - look at environment.rb.sample for an example.
2. Running the following: ```nohup ruby lib/webServer.rb &> /dev/null &``` or `ruby lib/webServer.rb`.
3. Test the app using curl `curl -XPOST localhost:4567/slack/trucks -d "command=/trucks"`.

## Credits:
* [Icon](https://www.flaticon.com/free-icon/food-truck_1046762#term=food%20truck&page=1&position=8) made by [Freepik](http://www.freepik.com) from www.flaticon.com is licensed by CC 3.0 BY
