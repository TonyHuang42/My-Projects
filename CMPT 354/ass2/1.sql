select Country, MPI_Urban, MPI_Rural from MPI_national
where MPI_Urban >= 0.1 and MPI_Rural >=0.2;