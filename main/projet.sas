libname Projet '/home/uxxxxxxxx/sasuser.v94/ProjetL3';

data Projet.table1;
  infile '/home/uxxxxxxxx/sasuser.v94/ProjetL3/Salaries.csv' firstobs=2 DLM=",";
  input rank$ discipline$ YsincePhD YService sex$ salary;


/* Correlation et Test de d'indépendance */

proc corr data=projet.table1;
quit;

proc freq data=projet.table1;
  table sex*salary / chisq;
quit;

proc freq data=projet.table1;
  table rank*salary / chisq;
quit;

proc freq data=projet.table1;
  table discipline*salary / chisq;
quit;


/* Similarité lois théoriques */

proc sort data=projet.table1;
  by salary;
quit;

proc univariate data=projet.table1 normal;
quit;

proc ttest data=projet.table1;
quit;


/* MACRO
* Effectue une régression simple entre deux variables (arg1 = arg2)
*/
%macro regressionsimple(arg1, arg2);
proc GLM data = Projet.table1;
  class discipline rank sex;
  model &arg1 = &arg2 /solution;
quit;
%mend;

/* MACRO
* Effectue une régression multiple entre deux variables (arg1 = arg2 arg3)
*/
%macro regressionmultiple(arg1, arg2, arg3);
proc GLM data = Projet.table1;
  class discipline rank sex;
  model &arg1 = &arg2 &arg3 /solution;
quit;
%mend;

/* MACRO
* Effectue une régression croisée entre trois variables (arg1 = arg2*arg3)
*/
%macro regressioncroisee(arg1, arg2, arg3);
proc GLM data = Projet.table1;
  class discipline rank sex;
  model &arg1 = &arg2*&arg3 /solution;
quit;
%mend;


/*
* Regarde les rapports entre le salaire avec les autres variables par
* régression simple pour émetre des hypothèses de corrélation
*/
%regressionsimple(salary, rank);
%regressionsimple(salary, discipline);
%regressionsimple(salary, YsincePhD);
%regressionsimple(salary, YService);
%regressionsimple(salary, sex);


/*
* Regarde les rapports entre le salaire avec les autres variables par
* régression multiple pour émetre des hypothèses de corrélation
*/
%regressionmultiple(salary, rank, discipline);
%regressionmultiple(salary, sex, rank);
%regressionmultiple(salary, sex, YsincePhD);
%regressionmultiple(salary, sex, YService);
%regressionmultiple(salary, rank, YsincePhD);
%regressionmultiple(salary, rank, YService);
%regressionmultiple(salary, YsincePhD, discipline);

proc GLMSELECT data=Projet.table1;
  class discipline rank sex;
  model salary = sex discipline rank YsincePhD YService;
quit;


/*
* Regarde les rapports entre le salaire avec les autres variables par
* régression multiple croisée pour émetre des hypothèses de corrélation
*/
%regressioncroisee(salary, rank, discipline);
%regressioncroisee(salary, sex, rank);
%regressioncroisee(salary, sex, YsincePhD);
%regressioncroisee(salary, sex, YService);
%regressioncroisee(salary, rank, YsincePhD);
%regressioncroisee(salary, rank, YService);
%regressioncroisee(salary, YsincePhD, discipline);

proc GLMSELECT data=Projet.table1;
  class discipline rank sex;
  model salary =  	sex discipline rank YsincePhD YService
  					YsincePhD*discipline
  					rank*discipline
  					sex*rank
  					sex*YsincePhD
  					sex*YService
  					sex*discipline
  					rank*discipline
  					rank*YService
  					rank*YsincePhD
  					YsincePhD*YService
  					rank*sex*discipline 
  					rank*sex*YsincePhD
  					rank*sex*YService
  					rank*YService*YsincePhD
  					rank*discipline*YsincePhD
  					rank*sex*discipline*YService*YsincePhD;
quit;
