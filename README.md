# schelling
Schelling segregation model - MATLAB

Thomas Schelling, in 1971, showed that a small preference for one's neighbors to be of the same color could lead to total segregation. He used coins on graph paper to demonstrate his theory by placing pennies and nickels in different patterns on the "board" and then moving them one by one if they were in an "unhappy" situation. Here's the high-tech equivalent. The rule this ALife model operates on is that for every colored cell, if greater than 33% of the adjacent cells are of a different color, the cell moves to another randomly selected cell.

For more information on Schelling's segregation model, please see:
Schelling, Thomas C. 1971. "Dynamic Models of Segregation." Journal of Mathematical Sociology 1:143-186. 

Sample simulation result for 50 % happines threshold and time steps 0, 4, 30:

![alt tag](https://raw.github.com/b3rnoulli/schelling/master/sample%20simulation.png)
