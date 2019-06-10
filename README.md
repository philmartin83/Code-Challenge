# Demo Project

This is a small demo of my coding style as of Swift 5, in side the project I make a basic request and get a response and map using the codeable protocal.

I use a cocoa pod called TinyContraints to handle my view layout because in my opinion is a lot cleaner and mor readable the using NSLayoutConstraints and there is no need to set translatesAutoresizingMaskIntoConstraints because TinyConstraints does it for you.

TinyConstraints https://github.com/roberthein/TinyConstraints

This demo makes a request to an end point and using the Codeable protocol maps the response data to a base struct, this data is then presented in a basic UI, the UI uses my own incrementing label https://github.com/philmartin83/PMCountingLabel
and an animated circular progressview
