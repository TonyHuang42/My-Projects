select distinct MPI_national.Country, MPI_Urban, MPI_Rural, MPI_National 
from MPI_national join MPI_subnational using(ISO)
where MPI_Urban >= 0.1 and MPI_Rural >=0.2 and MPI_National is not null
order by MPI_National;