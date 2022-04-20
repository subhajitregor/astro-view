#  AstroView in **(VIP)** with **SOLID Principles**

### NASA releases the Astronomy Picture of the Day everyday. This is accompanied by the title of the picture and a short explanation of about it. In this App the user can see the daily picture.

#### **API source: https://api.nasa.gov **
#### **Endpoint: https://api.nasa.gov/planetary/apod **

### What does this do?

  - As user launch the app, they arrives at the APOD page which display the image of Astronomy Picture of the Day**(APOD)** along with the title and explanation, for that day.
  
  - If user has not seen the APOD page today AND the phone is not connected to the internet and the user arrives at the APOD page Then: The page should display an error "We are not connected to the internet, showing you the last image we have." AND The page display the image of Astronomy Picture of the Day along with the title and explanation, that was last seen by the user.
  
  - if the NASA APOD API is up (working) AND the phone is connected to the internet When: The APOD image loads fully on the screen Then: The user should be able to see the complete image without distortion or clipping.
  
### How does it do that?
  
  - The app has been architected using **Clean Architecture**.
  - The app implements **SOLID** principles for each layer and even while communicating between them.
  - The app has 3 layer:
     1. Scene Layer.
        
        Scene Layer works in *VIP* Architecture.
        
     2. Service Layer.
     
        Uses Clean Architecture within
        
     3. Main Layer.
     
        Composes layers in Module factory.
        
  - Every Layer is following Dependency Inversion and don't have any strong dependencies with each other.
  - Every Layer can be seperated in their own modules.
  
  
#### Improvement Points:

  - Persistent Store can be updated and only this has not been implemented properly.
  - Scene Routers are not implemented and can be done.
  - Data transfer between two scenes needs to be handled. 
