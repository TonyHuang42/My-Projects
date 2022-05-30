create table if not exists MPI_national(
ISO text primary key,
Country text,
MPI_Urban real check(MPI_Urban >= 0 and MPI_Urban < 1),
Headcount_Ratio_Urban real check(Headcount_Ratio_Urban >= 0 and Headcount_Ratio_Urban < 100),
Intensity_of_Deprivation_Urban real check(Intensity_of_Deprivation_Urban >= 0 and Intensity_of_Deprivation_Urban < 100),
MPI_Rural real check(MPI_Rural >= 0 and MPI_Rural < 1),
Headcount_Ratio_Rural real check(Headcount_Ratio_Rural >= 0 and Headcount_Ratio_Rural < 100),
Intensity_of_Deprivation_Rural real check(Intensity_of_Deprivation_Rural >= 0 and Intensity_of_Deprivation_Rural < 100)
);


create table if not exists MPI_subnational(
ISO text,
Country text,
Sub_national_region text,
World_region text check(World_region == "Sub-Saharan Africa" or World_region == "Latin America and Caribbean" or World_region == "East Asia and the Pacific" 
	or World_region == "Arab States" or World_region == "South Asia" or World_region == "Europe and Central Asia"),
MPI_National real check(MPI_National >= 0 and MPI_National < 1),
MPI_Regional real check(MPI_Regional >= 0 and MPI_Regional < 1),
Headcount_Ratio_Regional real check(Headcount_Ratio_Regional >= 0 and Headcount_Ratio_Regional < 100),
Intensity_of_Deprivation_Regional real check(Intensity_of_Deprivation_Regional >= 0 and Intensity_of_Deprivation_Regional < 100),
primary key (Sub_national_region, ISO),
foreign key (ISO) references MPI_national(ISO) 
);