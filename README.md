# App
Android/Flutter App for TravelX

About: TravelX is intended to alleviate the stress of the COVID-19 experience. Fear of exposure during routine shopping trips or family outings is a serious concern for many families. In order to allow families to make more informed decisions about these trips, the developers have developed an algorithm based on published data which provides a metric for assessing risk using crowd reporting. Although it is by no means definitive, it can help to quantify the degree of risk individuals will be taking on in the hopes of reducing anxiety and encouraging better choices. With the additional information regarding crowd densities and weather, families and individuals can plan their trips to minimize potential exposures and minimize time spent waiting in line or looking for out-of-stock items.

How It Works: TravelX is a crowd reporting app which enables users to provide information that can help calculate their degree of risk. Data which is reported by the users includes use of face coverings, implementation of social distancing, the recommended COVID capacity of the location, and the actual crowd size at the location. These are factored into calculations which help inform other users' travel decisions with the aim of making the public more informed.

Using studies published in The Lancet, the probabilities of COVID transmission have been quantified in terms of face covering use and social distancing. Other studies have determined a rough correlation between density and number of deaths, so in the interests of being conservative for the purposes of maximum safety, these correlations have been carried over into the calculation. All of these pieces of data are factored into a score which is then place into one of five categories:

VERY LOW: You are safe, but make sure to wear a face covering and maintain appropriate distance. LOW: You are safe, but make sure to wear a face covering and maintain appropriate distance. MEDIUM: With appropriate face covering and social distance, you should be safe. HIGH: This location may be unsafe - consider returning at another time. VERY HIGH: This location is not safe or does not comply with suggested guidelines.

Users are also presented with information regarding how crowded their location of interest is, and how the crowd density changes over the course of the day. For stores and other establishments, users can also find out when they open and close. Finally, users can obtain weather information such as the temperature, expected weather conditions, and probability of precipitation for outdoor venues or events.

Data on fluctuations in crowd density and location data are obtained from the Google Maps API and the populartimes Github repository, as created by user m-wrzr. Data on weather conditions are collected using the latitude and longitude corresponding to the searched location, and are provided by the OpenWeather API. The server which hosts the necessary Python code and carries out the POST requests is hosted on AWS, with user authentication provided by Auth0.

How To Use It: TravelX is implemented in Flutter and currently compatible with Android devices. Users can log in or create an account via Auth0, after which they can search for their intended destination. Information regarding weather, crowd density (if applicable) and risk score will be displayed. In the event that they are the first user to report data on risk, there may be no data displayed regarding the risk score. Furthermore, no crowd density data is available for residences or similar locations. If the user would like to report data regarding the risk score, they may select the "Submit Report" floating button to fill in information regarding face covering use, social distancing, crowd size, and the adjusted maximum capacity (due to COVID).

This application was developed by Rohan Harish and Varun Pai. Thank you to all of the healthcare workers, scientists and public health advocates, and essential personnel working tirelessly to ensure our nation's resilience in this trying time.


FOR TESTING PURPOSES, USE THE FOLLOWING ESTABLISHMENTS:
Costco Wholesale, Edison, NJ
Walmart Supercenter, Hackettstown, NJ
Any other store or establishment will have crowd and weather data, but no risk score. However, adding a risk score using the submit report button and form will be displayed if that establishment is searched for again.
