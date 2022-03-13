libname LogdeSta '/home/uxxxxxxxx/sasuser.v94/ProjetL3';

data LogdeSta.table1;
  infile '/home/uxxxxxxxx/sasuser.v94/ProjetL3/Salaries.csv' firstobs=2 DLM=",";
  input rank$ discipline$ YsincePhD YService sex$ salary;

/* MACRO
* Effectue une régression simple entre deux variables (arg1 = arg2)
*/
%macro regressionsimple(arg1, arg2);
proc GLM data = LogdeSta.tablechiffree;
  class discipline rank sex;
  model &arg1 = &arg2;
quit;
%mend;

/* MACRO
* Effectue une régression entre trois variables (arg1 = arg2*arg3)
*/
%macro regression2(arg1, arg2, arg3);
proc GLM data = LogdeSta.table1;
  class discipline rank sex;
  model &arg1 = &arg2*&arg3;
quit;
%mend;

/* MACRO
* Effectue une régression entre quatre variables (arg1 = arg2*arg3*arg4)
*/
%macro regression3(arg1, arg2, arg3, arg4);
proc GLM data = LogdeSta.table1;
  class discipline rank sex;
  model &arg1 = &arg2*&arg3*&arg4;
quit;
%mend;


/*
* Regarde les rapports entre le salaire avec les autres variables par
* régression simple pour émetre des hypothèses de corrélation
*/
%regressionsimple(salary, rank);
%regressionsimple(salary, discipline);
%regressionsimple(salary, YsincePhD);
%regressionsimple(salary, Yservice);
%regressionsimple(salary, sex);

%regressionsimple(YsincePhD, rank);
%regressionsimple(YService, rank);

/*
* Regarde les rapports entre le salaire avec les autres variables par
* régression multiple pour émetre des hypothèses de corrélation
*/
%regression2(salary, rank, discipline);
%regression2(salary, discipline, sex);
%regression2(salary, sex, rank);
%regression2(salary, sex, YsincePhD);
%regression2(salary, sex, YService);

%regression3(salary, sex, discipline, YsincePhD);
