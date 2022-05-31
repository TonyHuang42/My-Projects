int: num;
int: cap;
int: refill;
set of int: games=1..num;
array[games] of int: fun;
array[games] of var int: G;
array[games] of var int: tokens;

constraint forall(i in games)(1 <= G[i]/\ G[i]<= tokens[i]);
constraint forall(i in games where i>1)((tokens[1]=cap)/\(tokens[i]=tokens[i-1]-G[i-1]+refill)/\((tokens[i]>cap)->tokens[i]=cap)); 

solve maximize sum(i in games)(fun[i]*G[i]);
var int: total_fun = sum(i in games)(fun[i]*G[i]);
output[show(total_fun)];