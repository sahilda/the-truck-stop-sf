# The Truck Stop SF plugin

A simple app that responds to Slack commands with today's menu for the Truck Stop SF http://www.truckstopsf.com/ and Parklab https://www.parklabjunction.com/.

## USAGE:

### Slack:

<a href="https://slack.com/oauth/authorize?scope=commands&client_id=207679880451.420459731748"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>

There are three different commands:
* /trucks-help - get help
* /parklab - get today's Parklab menu
* /truck-stop - get SF Truck Stop's menu

## TODOs:
* Extend it to work on all Slack rooms
* Change the 'location' sub command to return an image
* Make it work with HipChat
* Modify the message to add line breaks between trucks **(done)**
* Modify the script to check current SF time instead of system time **(set to PST, so no daylight savings is taken into account, but good enough)**
* Enhance the message to add links to each truck's website **(done)**
* Handle the case where their website is not updated with this week's menu **(done)**

## Testing / Self installation:
1. Setting up environment.rb - look at environment.rb.sample for an example.
2. Running the following: ```nohup ruby lib/webServer.rb &> /dev/null &``` or `ruby lib/webServer.rb`.
3. Test the app using curl commands: 
```
curl -XPOST localhost:4567/slack/trucks -d "command=/truck-stop"
curl -XPOST localhost:4567/slack/trucks -d "command=/parklab"
```

## Credits:
* [Icon](https://www.flaticon.com/free-icon/food-truck_1046762#term=food%20truck&page=1&position=8) made by [Freepik](http://www.freepik.com) from www.flaticon.com is licensed by CC 3.0 BY
