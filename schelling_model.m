%% simple segregation simulation
sch = Schelling(50, 50, 0.3, 0.5, 1000, 'schelling_simulation');
sch = sch.populate();
sch.update();
