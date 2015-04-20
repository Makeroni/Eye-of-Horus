# Eye-of-Horus

Eye of Horus is an open source platform to control any device just looking at them. The project (hardware & software) was built from scratch during the Space Apps Zaragoza to solve the Space Wearables challenge. This device could help engineers from NASA and astronauts on their tasks. The system combines eye tracking with a frontal camera to know where you are looking. The target devices are identified using light beacons (similar to LiFi technology) and controlled with wireless protocols.

![Logo][logo] Interacting with objects just looking at them has always been a dream for humans.

NASA engineers doing lab and field work often need to operate with computers and other tools but in some situations this interaction is not easy and may cause them to interrupt their activities. The absence of gravity hinders the mobility of the astronauts inside the station and may affect their work and safety. We accepted the Space Apps challenge for creating a wearable accessory that could help people interacting with computers, electronic devices and also everyday things just looking at them.

1. **Challenge:** The challenge is to design and build a wearable accessory that could be useful for the NASA ground engineers and also astronauts in their lab or field activities. The device would facilitate their work through a natural interface so they can do different things without using their hands. Thanks to it, they will be able, for instance, to interact with a distant control panel just looking at it.

2. **Wearables:** Wearable refers to the set of electronic devices which are incorporated in any part of our body that continuously interact with the user and other devices in order to perform a specific function. Smart watches, sports shoes built-in with GPS and bracelets that monitor our health are examples of this technology which is increasingly present in our lives. One of the best known wearables is Google Glass. Our device could be designed as an accessory to use with Google Glass to simplify the hardware and reduce its costs.

3. **3D printing:** The device must be durable and made from a non-brittle material. Due to this, we have decided to make it using 3D printers. This technology is cheap and easy to build so the device could be replicated worldwide or even in the space. NASA engineers could improve the device in their labs in a minute and astronauts could produce or fix it using the 3D printers at the station.

4. **Open Source:** We believe open knowledge is contributing to a better world and Eye of Horus is designed as an open source platform, both hardware and software.
The schematics and the implemented software can be found in the project Github repository, allowing people to modify, improve and redistribute their contributions.

5. **Internet of Things:** The Internet of Things (IoT) is a growing trend that extends internet connectivity beyond traditional devices like computers, smartphones and tablets to a diverse range of devices and everyday objects. This revolution increases the possibilities of the Eye of Horus allowing you to control the light level of your kitchen or turning on the coffee machine just using your vision. Therefore, the device must have built-in wireless capabilities, which is the base of IoT.

6. **Low Cost Solution:** We have developed a simple and low cost solution to detect and identify the objects in our surrounding. Infrared leds are used as light beacons (similar to LiFi technology) emitting different frequency pulses for each device (PC, camera, TV, microwave...). The frontal camera of our dispositive detects this light, differentiating and communicating the objects when you look at them.

# APPLICATIONS

Eye of Horus lets you interact with devices and objects just looking at them. The main application in the current challenge is to improve the work and safety of the NASA ground engineers and astronauts but this device could also make common people's lives easier:

- -Disability. People with functional diversity or who is hospitalized could use it to perform tasks which would be impossible due to their reduced mobility.

- -Driving safety and control. Thanks to our device, drivers could interact with the radio or car phone with both hands on the wheel. Their eyes could be also monitored to detect drowsiness or lack of attention on the road and prevent a potential accident.

- -Entertainment. It could be used as an eye-controlled mouse to play video games and position the targets just looking at them.

# HARDWARE

The hardware development efforts were split in two different branches:

- 1) Design and fabrication of the 3D printed case and frame.

- 2) Design and assembly of the required electronic components.

### Rubén Martín, member of Eye of Horus:

> The hardware is HARD!

 **3D Printing** 

The casing was designed to integrate the electronic components of the system. It consists of several 3D printed pieces to hold and position the camera, the infrared lights and allocate the electronics and batteries.  The complete 3D model can be viewed online in the following [link](http://p3d.in/e/JN2Oy+load).

We started with a simple design that has been improved to the current version:

- *Version 1*: The first goal was to design and fabricate a case which could be fitted as an accessory of the Google Glass. A replica was 3D printed as we did not have an actual product. The casing consists of a small box containing the battery and the processor connected through an USB wire to the camera. An articulated tube which ends in the camera holder and the infrared lights allows the system to be mobile and frame the eye pupil.

- *Version 2*: In the second version, which is the end of this prototype, the molding of the glasses is independent and functional without the need of the Google Glass. The look and the fastening system of the electronic components have been improved in this second version.

![Designed frame and casing][3d]

 **Electronic design** 

- **Eye Tracking device**

This part corresponds to the wireless system that captures and analyzes the eye pupil images under infrared illumination.

During the development process, several iterations have been made improving the prototype features and finally designing a printed circuit board (PCB) that could be manufactured with a low cost.

***Prototype 1***: A first prototype was built over the table with no case to test hardware and software.

![Prototype image][proto1]

The parts used in the different prototypes are common:

-  [VoCore v1.0](http://vocore.io/):  VoCore is a coin-sized Linux computer with wireless capabilities. It is also able to work as a fully functional router. It runs OpenWrt on top of Linux and contains 32MB SDRAM, 8MB SPI Flash and using 360MHz MIPS processor.

- Power circuit: It includes a system DC/DC which supply 5V to the circuit thanks to a lithium battery

- [Camera](http://www.alibaba.com/product-detail/7-1mm-mini-video-endoscope-camera_515483490.html): an small size USB endoscope camera was disassembled to remove the infrared blocking filter and replace it with a band pass filter with the oposite effect. This task was complicated due to the small size of the optical elements.

![Removing camera filter][camera]

- IR leds: infrared leds are responsible to illuminate the eye. The pupil is an aqueous medium that absorbs this light and results in a dark spot clearly visible in the images.

- Bandpass filter: a lens that filters the non-infrared frequencies of light emphasize the monochrome effect and prevents ambient light from affecting the system.

***Prototype 2***: Once the basic software and hardware was validated, a second version was developed to complete and integrate the system using the 3D printing models of the first version of the casing.

![Prototype image][proto2]

The system was modified to overcome the following hardware problems:

- Remove the electronic noise emitted by WiFi shield that affects data transmission in the camera wire.

- Correct the placement, orientation and intensity of the infrared LEDs for a correct eye pupil illumination.

All electronics components of the prototype were replicated in the second version to get a better finish of the product.

![Prototype image][proto3]

![Prototype image][proto4]

The assembly is the result of the first model of the product. It could be an addition to Google Glass using its front camera like a data gathering system of the physical world.

***Prototype 3***: On this part, a printed circuit board was designed based on the information obtained from the previous prototypes. It would allows a low cost and replicable electronic device. 

![Designed printed circuit boards][schematics]

This is a open source project, so all schematics are available. Anyone can download, edit and manufacture the device.

- **Light beacon device**

A prototype was designed using infrared flashlight pulses with adjustable frequency. This light, only visible in the front camera thanks to a band-pass filter, allow to differentiate the targeted devices.

![Light beacon device][beacon]

The system also integrates a bluetooth low energy (BLE) module which can receive requests from other devices. In our case, a computer linked with other BLE module is in charge of sending the turn on/off request when the main device indicates that the user is in front of the object and the eye tracking reveals that is looking at the beacon (in the example it would be a light lamp).

![Infrared images][ir]

The integrated components in this prototypes are:

- [Serial Bluetooth 4.0 BLE Module](http://www.tinyosshop.com/index.php?route=product/product&product_id=705): responsible for the communication of BLE with PC.

- [Relay control module](https://www.sparkfun.com/products/11042): to control a device connected to the network

- [Arduino Pro mini](http://www.arduino.cc/en/pmwiki.php?n=Guide/ArduinoProMini): the main microcontroller in charge of communicating with other modules and components.

- Infrared LED: responsible for carrying out the lighting flash.


# SOFTWARE

Our final goal is to obtain an autonomous device but during the weekend the software development was divided in two blocks: server and client. Server software is running inside the Eye of Horus while the client is running on a laptop computer.

**Server**

![Testing OpenWrt in the Vocore][openwrt]

This part of the software is executed in the VoCore module, a coin sized linux computer suitable for many  applications. This module acts as a server running OpenWrt, a Linux distribution for embedded devices.

The server software is in charge of:

- Capturing the video captured by the camera

- Streaming the data over WiFi using a lightweight webserver

**Client** 

![HTML5 eye interface][eyeint]

This part is in charge of:

- Receiving the video stream

- Processing the images of the eye in order to detect the center of the pupil

- Provide a user interface to calibrate the system

- Control the mouse in the laptop computer according to the coordinates dictated by the eye

The video stream in the client was processed in real time using HTML5. A segmentation library was developed from scratch to threshold the images and analyze its morphology to detect the pupil and compute its center of mass.

![Developed real time image segmentation library][code]

At this point, the user has a mouse controlled by his eye and can interact with any 3rd party software installed in the computer.

A demo of the client sofware recognizing the center of the pupil can be seen in our [website](http://makeronilabs.com/sites/nasa/eye_of_horus_interface/). You can play with the range selectors in order to see how it affects the recognition and reach optimal calibration when only the pupil is highlighted. The system will consider the center of gravity of the highlighted area as the coordinates where the eye is pointing. Calibration is very important and it may depend of the illumination. Thats the reason why the Eye of Horus has 4 leds illuminating the area of the eye. The pupil detection system has proven to be quite robust with the illumination provided by the device.

# DEMOS

Here you can find some examples of use:

 [Eye of Horus - Open Source Eye Assistance](https://vimeo.com/125373219) 

 [Eye of Horus Demo 1](https://vimeo.com/125396508) 

 [Eye of Horus Demo 2](https://vimeo.com/125396713) 

 [Eye of Horus Demo 3](https://vimeo.com/125396803) 

 [Eye of Horus Demo 4](https://vimeo.com/125396891) 


# FUTURE

The most important part of this project is the viability and profitability. We believe this project is highly sustainable. We can create a crowdfunding campaign using all the documentation.


### Borja Latorre, member of Eye of Horus:

>Never think about the future because it comes soon.


![The future][future]

We have the support of the City of Zaragoza and other incubators project to move forward. We also collaborate with numerous technological associations in our city. We have succeeded in 48 hours a functional prototype to show our system. It is easy to build, cheap and technological.

### Jose Luis Berrocal, member of Eye of Horus

> People say that space is unlimited. We also believe that our project has no limits. 

# OUR SPACE APPS WEEKEND:

During this amazing weekend we met very nice people, participated in one of the most important experiences of our lives, learning at every moment and developing after 48 hours of hard work a final product. 

![Our space apps weekend][weekend]

### Luis Martín, member of Eye of Horus

> A unique experience, an amazing team and an impressive project. 

Here you can see our weekend and several milestones that have marked the achievement of the project:

- **SATURDAY**: 

- **9:00**: Space Apps Zaragoza START.

- **10:00**: Make your team, present your idea: We want to participate in the Wearables Challenge developing a real product involving hardware and software.

- **10:30**: Brainstorming: We have a 3D printer, some microcontrollers, electronics components, a solder... what can we do?.

- **11:00**: State of the art: We decide to create a device to eye tracking monitoring capable to control any electrical device mixing the tracking of the eye and a frontal camera that analyze the real world. We start searching some information about actual application of this technology and other similar projects.

- **11:30**: Meeting: We show the information collected to the team.

- **11:45**: Hardware: We design a first assemble (VOCORE board, DCDC board, battery and camera) to bring to the software developers a prototype to work with it.

- **12:00**: Software: We start to program the main code. This HTML code control and track the eye movements.

- **12:00**: Hardware: We create a 3D design of the first prototype. We develop the electronic case and the structure for placing the camera system on the head of a person.

- **12:45**: 3D printing: Our 3D printer (TAZ4 Lulzbot) start to print the first samples of the case. We rebuild the designs in other to improve our models.

- **13:45**: Software: We finish the basic code in HTML5 to track the eye movement.

- **14:00**: It is time to eat….PIZZA!! and talk with other team about their projects. Co-working 100% Thanks to the Space Apps Zgz organization.

- **14:30**: Meeting: We define the next millestones of the project. We decide to create a web interface to calibrate the device.
- **15:00**: 3D printing: We improve our designs in order to build the first version of the case. We print it!

- **15:30**: Software: We want to control the mouse of the computer with our eye as a example of application. We design a web interface to test and calibrate the device. 

- **17:00**: Hardware: We finish the power circuit assembly for the first prototype.

- **18:00**:  Software: We develop the web interface and the PHP code. This code is used to control the PC mouse using our eye track.

- **19:00**:  Documentation: We start to documentate all the software.

- **20:00**: It is time to eat….PIZZA AGAIN!! Night is coming in Zaragoza.

- **22:00**:  Night meeting: We talked about what happened during the day.

- **00:00**: We go to Makeroni space (a local technological association) to finish the first hardware prototype in the night.

- **SUNDAY**: 

- **4:00**: It is time to sleep

- **9:00**: Begins the second and final day. A cup of coffee and the batteries recharged.

- **10:30**: Meeting: We start the day with a real prototype and the basic software. This day we want to control a light, our computer and the TV with the eye like an example of use to use it for the presentation.

- **11:00**: Hardware: We have a lot of noise in the camera signal in the prototype. We can not continue working. We start to investigate where is the problem.

- **11:30**: Software: We use Processing IDE to create some examples of applications. 

- **11:45**: Hardware: The device still fails. We dismount the system piece by piece to find the error.

- **12:00**: Presentation: The presentation is a very important point in this event. We start before lunch.

- **12:00**: Software: We want to show our eye in the presentation and control it with our eye. So we decide to make the presentation with Reveal JS / HTML.

- **13:45**: Hardware: After several test and changes (battery, microcontroller, dcdc circuit) we find the problem. The wifi in our device makes a loud noise and the cable used was not shielded.

- **14:00**: The last meal before the presentations .... it could not be any other thing than PIZZA!!

- **14:30**: Presentation: We still working in a "amazing" presentation with slide eye control but we need a functional prototype.

- **15:00**: Software: We modify Reveal JS presentation to add the eye tracking function.

- **15:30**: Software: We want to control the mouse of the computer with our eye as a example of application. We design a web interface to test and calibrate the device. 

- **17:00**: General: We prepare hardware and software for the final part of the event.

- **18:00**:  PRESENTATION TIME: It's time to present our project to all attendees and prove that Eye of Horus is the best.

- **20:00**: Finish one of the best experiences of our lives.


# ABOUT US

The four members of the team have different technological backgrounds as electronic engineering, physics and computer science but we all share passion for making all kind of inventions mixing any available technology.

We are all members of [MAKERONI LABS](http://makeronilabs.com), a non profit that was born in Zaragoza in 2012 following the MAKER movement that is currently shaking the world.

Its main purposes are:

- Promote a collaborative workspace for the development of new technologies.

- Promote the dissemination of new technologies; both projects developed by members of the association, as other people. 

To fulfill these purposes are working on:

- Create and maintain a physical or virtual, collaborative work space.

- Promote and coordinate the development of technological projects for companies and individuals, by members of the association.

- Promote the capacities of members of the association in competitions, talks and exhibitions.

- Conduct outreach to the diffusion of new technologies activities.

### Makeroni Team

> We did this Open Source project for the Space Apps Challenge 2015. 
> We hope you will like it, use it for your inventions and in any way contribute to the project!

# MORE INFO

The Eye Of Horus project in our site: [Eye of Horus Project](http://makeronilabs.com/proyectos/37-eye-of-horus-open-source-eye-assistance) 


[logo]: http://makeroni.github.io/Eye-of-Horus/img/logo.png
[3d-model]: http://makeroni.github.io/Eye-of-Horus/img/3d-model.gif
[proto1]: http://siminelaki.org/noname/nasa/photos/prototype-0.png
[proto2]: http://siminelaki.org/noname/nasa/photos/prototype-1.png
[proto3]: http://siminelaki.org/noname/nasa/photos/prototype-2.png
[proto4]: http://siminelaki.org/noname/nasa/photos/prototype-3.png
[beacon]: http://siminelaki.org/noname/nasa/photos/prototype-4.png
[eyeint]: http://siminelaki.org/noname/nasa/photos/prototype-5.png
[future]: http://siminelaki.org/noname/nasa/photos/future.png
[weekend]: http://siminelaki.org/noname/nasa/photos/weekend.png
[schematics]: http://siminelaki.org/noname/nasa/photos/schematics.png
[3d]: http://siminelaki.org/noname/nasa/photos/3d-model.png
[openwrt]: http://siminelaki.org/noname/nasa/photos/openwrt.png
[ir]: http://siminelaki.org/noname/nasa/photos/ir.png
[camera]: http://siminelaki.org/noname/nasa/photos/camera.png
[code]: http://siminelaki.org/noname/nasa/photos/code.png

