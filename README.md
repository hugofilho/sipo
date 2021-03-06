# SIPO - Script Inference Parental Origin
![](/img/sipo_site.png)
###### Image credits (applied):https://images.app.goo.gl/DVk7WW4ET3FakNfN6 (Teacher: George Davey Smith) 

The SIPO was designed to identify Mendelian deviations (MD) observed in the genotyping data of autosomal SNPs of the children of each trio analyzed for different groups, and is compatible with the Thermo Fisher© platform using the GeneChip® CytoScan HD 750K. Subsequently, the authors compared the genotype of each marker (SNP) of the parents with the genotype of the respective marker of their children. The sex chromosomes were discarded from the analysis to avoid problems with low coverage and experimental noise observed on the Y and X chromosomes, respectively. 
 
## Data Input

The call of SIPO occurs using the syntax: perl sipo.pl |layout| |path_origin_file.txt| |path_output_file.csv| 
 
The authors highlight the format of the call.
* layout (Must observe the sequence generated by software ChAS - Thermo Fisher)
  * 1 -> Sequence: Offspring x Mother x Father
  * 2 -> Sequence: Offspring x Father x Mother
  * 3 -> Sequence: Mother x Father x Offspring
  * 4 -> Sequence: Mother x Offspring x Father
  * 5 -> Sequence: Father x Offspring x Mother
  * 6 -> Sequence: Father x Mother x Offspring
* path origin file
  * original file taken from chas (.txt). 
  * It has to be the complete path
  * File name cannot contain space
* path output file
  * output file generated by sipo (.csv or .txt). 
  * It has to be the complete path
  * file name cannot contain space
  
Using the SIPO call, it was possible to identify Mendelian inconsistencies in the genotypes of trios corresponding to de novo mutations that potentially represent mutations that occurred in the germ line of the father/mother, which was observed in the somatic tissue of the offspring. Diagram below represents the flowchart of the procedures for the detection of the Mendelian deviation in the present study.
![](/img/fluxo_sipo.png)

First, SIPO applied the filter with the confidence value <5x10E-2 to discard genotypes with low confidence value, disregarding the X and Y chromosome markers. With this, SIPO started the DM findings for each SNP marker. Therefore, inferences were designed to define the origin of the parent and consequently indicate the types of base substitutions. To close this study, the module was closed, using the R language resource (R Core Team, 2018), with the data analysis, through the extraction, quantification and applications of statistical techniques.

## Data Output

After the discovery of the MD, SIPO was able to identify the origin of the de novo mutation observed from the parents. Thus, it was possible to identify the origin of the de novo mutation from the parents, in addition to indicating the type of base replacement (In Table below). 

| Regarding the Origin of the Parent  |  Nitrogen Base Mutation |  Case|
|---|---|---|
|   | Maternal or Paternal Origin |Ex: Paternal (AC)/Maternal (AA)/Offspring (CC). However, for some scenarios, it was not possible to objectively identify the origin. For these and similar cases, the authors identified that it was generated from inference without progenitor origin|
|   | Maternal Origin | E.g.: Paternal (AC)/Maternal (AA)/Offspring (CC). However, for some scenarios, it was possible to objectively identify the origin|
|   | Paternal Origin | E.g.: Paternal (AA)/Maternal (GG)/Offspring (CG). However, for some scenarios, it was possible to objectively identify the origin|

| As for the type of base substitutions  |  type of base substitutions |  Case|
|---|---|---|
|   | Transition - Purine/Purine  |  Mutation occurs between Purines (A/G) |
|   | Transition - Pyrimidine/Pirimidine | Mutation occurs between Pirimidine (C/T)  |
|   | Transversal - Purine/Pyrimidine |  Mutation occurs between Purines and Pyrimidines (A/C or G/T) |

## Conclusion

The study allowed inferring the variation in Mendelian deviation findings that can be applied in different sample groups. Thus, with the results obtained, it was possible to identify that the tool also corroborates in the quality control of genotyping data, using as exclusion criteria the high numbers of observed Mendelian deviations. In this way, it can be applied as a support resource to help improve the quality of the genotyping dataset, as it identifies Mendelian deviations, causing these markers to be excluded from the data mass, if needed.

Therefore, with the incorporation of deductions for decision making about the origin of MD in the offspring, SIPO was able to identify through inference or without inference the parental origin of the deviations observed, as well as to indicate the type of base substitution.
