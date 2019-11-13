


## Project: Snake

As the title suggests this is a tutorial to make a Snake with 8 LEDs and your Microcontroller ATMEL 89C52. This is, turning all the LEDs ON one by one from the right to the left, turning them OFF in the same direction, turning them ON in the opposite direction and then OFF again in the same direction (left to right). Using your imagination, you’ll see a snake going from one side to the other; first leaving the “LEDs area”, coming back to it form the same side it left and then doing this cyclically until you disconnect the power source.
You’ll see a behavior like this:

  1. 0 0 0 0 0 0 0 0
  2. 0 0 0 0 0 1 1 1
  3. 0 1 1 1 1 1 1 1
  4. 1 1 1 1 1 1 1 1
  5. 1 1 1 1 1 1 1 0
  6. 1 1 1 1 0 0 0 0
  7. 1 0 0 0 0 0 0 0
  8. 0 0 0 0 0 0 0 0
  9. 1 0 0 0 0 0 0 0
  A. 1 1 1 1 0 0 0 0


We won’t analyze in deep the hardware requirements as that could be something that could vary depending on your implementation, however the following are 4 items that should be present for the code to work as it’s written:
  - Microcontroller ATMEL 89C52
  - 11.0592 MHZ crystal
  - 8 LEDs
  - Protoboard

Also you'll need consider the following list to setup your AT89C52 (based on this datasheet: https://www.datsi.fi...mel/doc0313.pdf):
  - +5V in the pin 40 (VCC)
  - +5V in the pin 31(EA/VPP)
  - GND in the pin 20
  - On page 12, figure 7 you'll find important information on how to connect your crystal.
  - On page 17, "DC Characteristics Table (VIH1)" you'll find limitations for the RST pin(9) where you usually need to connect a reset button.
