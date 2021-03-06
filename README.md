# Graff³
Graff3 (graff cube) is a tool that enables its users to express themselves by drawing and contributing to a virtual mosaic.

**Note:** The drawing canvas only works on mobile browsers right now because it can only detect touch events, and not mouse events.

## Done by
* Tommi
* De Xing, current student at Singapore Polytechnic
* Adam, current student at Singapore Polytechnic (FB: AdamTheSonOfAGun)
* Kenny, current student at Singapore Polytechnic
* Developed at AngelHack's [AppHack Singapore Fall 2013](http://www.hackathon.io/apphack14)
* [AppHack Project Page](http://www.hackathon.io/projects/3709)	

## How it came about
Graff3 (graffiti + cube) started off as an idea to develop a native android journaling  application using Samsung's S Pen SDK, and eventually evolved into the current state. We were inspired by a YouTube video featuring 3D graffiti and the Rubik's Cube. 

## What do we have now?
The current size of the mosaic is a simple 5x5 canvas. Anyone can visit the application and express him or herself by drawing on the simple HTML canvas. Then, the work of art can be submitted and it will immediately become part of the digital mosaic.

## What can be done?
* Size of the mosaic can be increased
* Supports multiple mosaic
* Supports private and public mosaic
* Supports more drawing tools
* 3D mosaic

## Technologies
* HTML5, JavaScript, jQuery Mobile, [JQMTouchPaint](https://github.com/Rockncoder/JQMTouchPaint)
* Backend: Ruby, Sinatra, hosted on Heroku
* Data: Redis, Amazon S3

### Technologies iterations

#### Client
**Before:** Native Android application + Samsung S Pen SDK

**At the end:** A simple web application using HTML5's Canvas + jQuery Mobile

#### Server
**Before:** Using Parse as a backend as a service. Then we realized Parse's cloud code's HTTP POST does not support multipartform-data.

**Then:** Switched to node.js on Heroku - met with difficulties using the knox package to upload binary files to Amazon S3.

**At the end:** Ruby Sinatra web app on Heroku + Redis + Amazon S3

## Code smells / bad practices
* Untested code
* Inline JavaScript
* Repeated code which can be extracted as a template
* Unmeaningful commit messages
* Can be forgiven since the current workable product was produced in less than 18 hours :D



