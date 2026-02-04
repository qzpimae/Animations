### URL Parameters
Control aspects of the simulation by adding parameters to the URL. For example, `index.html?alg=2&color=1&scale=5` can be used to start the simulation with specific settings.

Available Parameters:
- **alg**: Select initial population pattern (`0` for empty, `1`-`5` for pre-defined patterns).
- **color**: Set the color mode (`0`, `1`, `2`).
- **fade**: Toggle fading effect (0 for off, 1 for on).
- **scale**: Set cell size (default is 7).
- **ran**: Enable random life drops.
- **ranwait**: Interval for random life drops.
- **buff**: Frame buffer for adjusting simulation speed.
- **ui**: Toggle on-screen UI (1 for enabled, 0 for disabled).
- **light**: Enable or disable light mode (0 for dark, 1 for light).

Example URL: `index.html?alg=3&color=2&fade=1&scale=10&ui=0`


### Keyboard Controls
Use the following keyboard inputs to interact with the simulation:

- **`<` key**: Decrease simulation speed
- **`>` key**: Increase simulation speed
- **`Space` key**: Start/Pause the simulation
- **`f` key**: Toggle fullscreen mode
- **`r` key**: Reset the simulation
- **`c` key**: Clear the simulation grid

These controls allow you to adjust speed, control playback, and manage display and simulation settings in real time.


