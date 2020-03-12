%% simple segregation simulation
sch = Schelling(50, 50, 0.7, 0.7, 1000, 'schelling_simulation');
sch = sch.populate();
sch.update();
