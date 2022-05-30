select World_region, avg(MPI_Urban), avg(MPI_Rural)
from(
select distinct ISO, World_region, MPI_Urban, MPI_Rural
from MPI_national join MPI_subnational using (ISO))
group by World_region;