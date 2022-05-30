select distinct MPI_national.Country, MPI_Urban, MPI_Rural, MPI_National 
from MPI_national join MPI_subnational using(ISO)
where MPI_National is not null;