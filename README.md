# SIPO
![](/img/sipo_site.png)
###### Image credits (applied):https://images.app.goo.gl/DVk7WW4ET3FakNfN6 (Teacher: George Davey Smith) 
## Script Inference Parental Origin
**Sintaxe: perl sipo.pl <layout> <path_origin_file.txt> <path_output_file.csv>**
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
