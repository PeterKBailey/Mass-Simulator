# Mass Simulator Application - Peter Bailey

Simulate massive objects along with their properties and movements

## Execution

This is a program built with "processing" and runs using the processing IDE

## Issues

There are still bugs to be worked out. The basics of gravitational attraction and collisions between "planets" work however collisions do not push the planets away from eachother so theres the possibility of the planets getting stuck inside of eachother. Also gravitational force increases as the distance decreases, so when the X and Y forces are calculated for two planets which have very close X or Y values, the acceleration will increase towards infinity and at least one of the planets will shoot off.
