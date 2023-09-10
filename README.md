# Morsel - Kitchen Command Line

Designed for use on a dedicated Raspberry Pi terminal on your kitchen counter. Connects to a [m3lon](https://www.m3lon.com) pantry.

Features:
- Quickly record your thoughts and writings while you're in the kitchen
- Access the m3lon.com Melon Selector

![Morsel - Main Menu](https://github.com/mirthturtle/morsel-client/blob/master/morsel-menu.jpg "Morsel - Main Menu")

### To run on a Raspberry Pi:

Clone the repo into your home directory: `git clone https://github.com/mirthturtle/morsel-client.git`

Install dependencies: `gem install colorize httparty`

Add to ~/.bashrc: `alias morsel='cd /home/pi/morsel-client && ruby -Ilib bin/morsel'`

Reload bashrc: `. ~/.bashrc` and run the program with `morsel`.

To connect to your m3lon pantry, check your pantry's Settings page for your Morsel Code and make it an environment variable on your terminal: `export MORSEL_CODE=your-unique-code`
