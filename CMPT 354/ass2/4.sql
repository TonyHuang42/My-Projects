select World_region, avg(MPI_National)
from(
select distinct ISO, World_region, MPI_National 
from MPI_subnational)
group by World_region;