# theTruckStopSFHipChat

A simple app that responds to a HipChat channel with today's menu for the Truck Stop SF [http://www.truckstopsf.com/]. Right now, this app only responds to a single, particular HipChat channel.

#### TODOs:
* Make it extendable to any HipChat room
* Modify the message to add line breaks between trucks **(done)**
* Modify the script to check current SF time instead of system time **(set to PST, so no daylight savings is taken into account, but good enough)**
* Enhance the message to add links to each truck's website
* Handle the case where their website is not updated with this week's menu **(done)**

#### Run the app by:
1. Setting up environment.rb - look at environment.rb.sample for an example.
2. Running the following: nohup ruby webServer.rb &> /dev/null &
