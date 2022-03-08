libname LogdeSta '/users/licence/ii07864/LogdeStat/Projet';
run;

data LogdeSta.table1;
  infile '/users/licence/ii07864/LogdeStat/Projet/Salaires universitaires/Salaries.csv' firstobs=2 DLM=",";
  input rank$ discipline$ YsincePhD YService sex$ salary;
run;

data LogdeSta.tablechiffree;
  set LogdeSta.table1;
  if sex='Male' then sex = 0;
  if sex='Female' then sex = 1;
run;


proc GLM data = LogdeSta.tablechiffree;
  class discipline rank sex;
  model salary = sex*rank  /noint;
run; quit;
