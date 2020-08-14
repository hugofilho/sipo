# Um documento em Markdown para a montagem de resultados do artigo final

## Exercício 1: Revisão dos tópicos sobre: 
- Pacote dplyr
- Pacote ggplot2

## Exercício 2: Criar um fluxograma que desenha o pipeline de um RNA-Seq


```r
##Fluxo do algoritmo: SIPO
library(DiagrammeR)
mermaid(" 
    graph TB 
      id1(SIPO)==>id2[DATA <br/> MINING]
      id2==>id3(CALL RATE > 0.05)
      id3==>id4(AUTHENTICATE <br/> LAYOUT);
      id4==>id5(ASSAY VARIABLES) 
      id1==>id6[CALL GENOTYPES] 
      id6==>id7(MOTHER'S CALL BASE) 
      id7==>id8(FATHER'S CALL BASE)
      id8==>id9(OFFSPRING'S CALL BASE)
      id1==>id10[MENDELIAN DEVIATION]
      id10==>id11(WITHOUT <br/>INFERENCE)
      id10==>id12(WITH <br/>INFERENCE)
      id12==>id13(LOWEST CONFIDENCE CALL)
      id13==>id14(NEAREST MUTATION); id14==>id15 
      id11==>id15>OUTPUT: ORIGIN OF THE MUTATION <br/>AND TYPE OF SUBSTITUTION]
") 
```

```r
##Fluxo do metodolologia: SIPO
mermaid(" 
    graph TB 
      id1(SIPO)==>id2[File Handling]
      id2==>id3(Mapping Variables)
      id3==>|Base Calling| id4(Identifying or <br/> Deducing Mutation)
      id4==>id5(Generating <br/> Origin of the Mutation) 
      id5==>id6(Generating <br/> Type of Substitution) 
      id6==>id7(Loading Database)
      id7==>id8(Ploting)
      id7==>id9(Statistic Testing)
      id7==>id10(Clustering)
      id7==>id11[PCA]
") 

```
```r
#Normalidade e Variância
  ## 1. Testes de normalidade
  Parâmetros:
  xbCaso <- mean(dfCasoDM$dm_caso) # média
  xbControl <- mean(dfControlDM$dm_control) # média
  meCaso <- median(dfCasoDM$dm_caso) # mediana
  meControl <- median(dfControlDM$dm_control) # mediana
  sxCaso <- round(sd(dfCasoDM$dm_caso), digits = 2) # desvio padrão
  sxControl <- round(sd(dfControlDM$dm_control), digits = 2) # desvio padrão
  cat("\n Média amostral do Grupo Caso =", xbCaso, "\n Desvio padrão amostral do Grupo Caso =", sxCaso, "\n Mediana amostral do Grupo Caso =", meCaso)
  cat("\n Média amostral do Grupo Controle =", xbControl, "\n Desvio padrão amostral do Grupo Controle =", sxControl, "\n Mediana amostral do Grupo Controle =", meControl)
t1Caso <- shapiro.test(rnorm(dfCasoDM$dm_caso, xbCaso, sxCaso)) # Shapiro-Wilk Caso
t1Control <- shapiro.test(rnorm(dfControlDM$dm_control, xbControl, sxControl)) # Shapiro-Wilk Controle

```

```r
##estatísticas do grupo caso
dfCasoDM<-read.csv("dfCasoDM.csv",header = TRUE,sep = ",",dec = ".")
dfIdadeGeral<-read.csv("dfIdadeGeral.csv",header = TRUE,sep = ";",dec = ".")
meanCaso <- round(mean(dfCasoDM$dm_caso), digits = 2)
sdCaso <- round(sd(dfCasoDM$dm_caso), digits = 2)
medianaCaso <- round(median(dfCasoDM$dm_caso), digits = 2)
somaCaso <- round(sum(dfCasoDM$dm_caso), digits = 2)
meanAgePatIdadeCase<-round(mean(dfIdadeGeral$age_pat_case), digits = 2)
meanAgeMatIdadeCase<-round(mean(dfIdadeGeral$age_mat_case), digits = 2)
sdAgePatIdadeCase<-round(sd(dfIdadeGeral$age_pat_case), digits = 2)
sdAgeMatIdadeCase<-round(sd(dfIdadeGeral$age_mat_case), digits = 2)
table(meanCaso, sdCaso, medianaCaso, somaCaso, meanAgePatIdadeCase, meanAgeMatIdadeCase, sdAgePatIdadeCase, sdAgeMatIdadeCase)
print(table(meanCaso, sdCaso, medianaCaso, somaCaso, meanAgePatIdadeCase, meanAgeMatIdadeCase, sdAgePatIdadeCase, sdAgeMatIdadeCase), zero.print = ".")
##estatísticas do grupo controle
dfControlDM<-read.csv("dfControlDM.csv",header = TRUE,sep = ",",dec = ".")
meanControl <- round(mean(dfControlDM$dm_control), digits = 2)
sdControl <- round(sd(dfControlDM$dm_control), digits = 2)
medianaControl <- round(median(dfControlDM$dm_control), digits = 2)
somaControl <- round(sum(dfControlDM$dm_control), digits = 2)
meanAgePatIdadeControl<-round(mean(dfIdadeGeral$age_pat_control), digits = 2)
meanAgeMatIdadeControl<-round(mean(dfIdadeGeral$age_mat_control), digits = 2)
sdAgePatIdadeControl<-round(sd(dfIdadeGeral$age_pat_control), digits = 2)
sdAgeMatIdadeControl<-round(sd(dfIdadeGeral$age_mat_control), digits = 2)
table(meanControl, sdControl, medianaControl, somaControl, meanAgePatIdadeControl, meanAgeMatIdadeControl, sdAgePatIdadeControl, sdAgeMatIdadeControl)
print(table(meanControl, sdControl, medianaControl, somaControl, meanAgePatIdadeControl, meanAgeMatIdadeControl, sdAgePatIdadeControl, sdAgeMatIdadeControl), zero.print = ".")
```

```
## Pipeline no PLINK:
## plink --file cesio --mind 0.1 --recode --out cesio
## plink --file cesio --maf 0.1 --nonfounders --noweb
## plink --file cesio --make-bed --out cesio
## plink --bfile cesio
## PRUNING
## plink --bfile cesio --indep-pairwise 500 5 0.1 
## plink --bfile cesio --extract plink.prune.in --make-bed --out prunedcesio
## plink --bfile cesio --missing --out miss_stat
## Associação das variâncias entre caso e controle
## plink --bfile cesio --assoc --nonfounders --out as1 
## plink --bfile cesio --assoc --adjust --nonfounders --out as2
## plink --bfile cesio --model --nonfounders --out mod1
## plink --bfile cesio --model --cell 5 --snp rs3845291 --out mod2
## plink --bfile cesio --cluster --mc 2 --ppc 0.05 --out str1
## plink --bfile cesio --mh --within str1.cluster2 --adjust --out aac1
## plink --bfile cesio --cluster --cc --ppc 0.01 --out version2
## plink --bfile cesio --mh --within version2.cluster2 --adjust --out aac2
## plink --bfile cesio --cluster --K 2 --out version3
## plink --bfile cesio --mh --adjust --out aac3
## plink --bfile cesio --cluster --matrix --out ibd_view
## plink --bfile cesio --cluster --distance-matrix --nonfounders --out ibd_view
```

```r
setwd("Drive:/../plink")
m <- as.matrix(read.table("ibd_view.mibs"))
md <- as.matrix(read.table("ibd_view.mdist"))
mds <- cmdscale(as.dist(1-m))
scale <- cmdscale(as.dist(1-md))
k <- c( rep("orange",45) , rep("blue",44) )
plot(mds,pch=20,col=k)
plot(scale,pch=20,col=k)
```

```
## Contruindo o PCA a partir dos dados gerados no pruning
## plink --bfile prunedcesio --bmerge prunedcesio.bed prunedcesio.bim prunedcesio.fam --make-bed --out pruned.merge.cesio
## plink2 --bfile pruned.merge.cesio --nonfounders --pca --out pca.pruned
```
```r
##Gerando os gráficos de PCA a partir das informações eigenvector gerado no plink2
library(ggplot2)
library(tidyr)
library(devtools)
library(pca3d)
setwd("Drive:/../plink2")
pca.plink<-read.table("pca.pruned.eigenvec",header = TRUE,sep = "\t",dec = ".")
pca.plink.num<-pca.plink[,-1]
pca.plink.num.x<-pca.plink.num[,-1]
stand.pca.plink<-scale(pca.plink.num.x)
res.pca.plink<-prcomp(stand.pca.plink, center = TRUE)
group<- factor(pca.plink[,1])
p.pca3d.plink<-pca3d(res.pca.plink, group = group, legend="topleft")
p.pca2d.plink<-pca2d(res.pca.plink, group = group, legend="topleft")
```
```r
library(magrittr)
library(plotly)
#Plot Box-Plot para numero de DM: Caso X Controle
f1 <- list(
  family = "Arial, sans-serif",
  size = 18,
  color = "lightgrey"
)
f2 <- list(
  family = "Old Standard TT, serif",
  size = 14,
  color = "black"
)
a <- list(
  title = "Mendelian Deviation",
  titlefont = f1,
  showticklabels = TRUE,
  tickangle = 0,
  tickfont = f2,
  exponentformat = "E"
)
b <- list(
  title = "Group",
  titlefont = f1,
  showticklabels = TRUE,
  tickangle = 0,
  tickfont = f2,
  exponentformat = "E"
)
bpDM<-plot_ly(dfCasoDM, y = ~dfCasoDM$dm_caso, type = "box",name="Case", boxpoints = "all", jitter = 0.1, pointpos = -1.9)  %>%
	add_trace(dfControlDM, y = ~dfControlDM$dm_control, type = "box",name="Control", boxpoints = "all", jitter = 0.1, pointpos = -1.9) %>%
    layout(xaxis = b, yaxis = a, title = "Nº Mendelian Deviation")
```
```r
library("gplots")
library(RColorBrewer)
library(tidyverse)
dfDMGrupo<-read.csv("dfDMGrupo.csv",header = TRUE,sep = ",",dec = ".")
# Cleveland dot plot
norder <- dfDMGrupo$family[order(dfDMGrupo$group, dfDMGrupo$dm)]
dfDMGrupo$family <- factor(dfDMGrupo$family, levels = norder)
pCleveland<-ggplot(dfDMGrupo, aes(x=dm, y=family)) +
	geom_segment(aes(yend=family), xend=0, colour="grey50") +
	geom_point(size=3, aes(colour=group)) +
	scale_colour_brewer(palette="Set1", limits=c("Case","Control"), guide=FALSE) +
	theme_bw() +
	      theme(panel.grid.major.y = element_blank(), # No horizontal grid lines +
	            legend.position=c(1, 0.55), # Put legend inside plot area
	            legend.justification=c(1, 0.5)) +
	facet_grid(group ~ ., scales="free_y", space="free_y") +			
	labs(title="Mendelian Deviation vs Family ~ Group", x="Mendelian Deviation", y = "Family")

```
```r
library("ggpubr")
dfMeiose<-read.csv("dfMeiose.csv",header = TRUE,sep = ",",dec = ".")
# plot Eclipse
pElipse<-ggscatter(dfMeiose, x = "num.meiose", y = "tx.meiose",
   color = "grupo", shape = "grupo",
   palette = c("#00AFBB", "#E7B800"),
   ellipse = TRUE, mean.point = TRUE,
   star.plot = TRUE)+
  theme_bw()
ggpar(pElipse, 
	   main = "Mutation Rate vs Number of Paternal Meioses",
	   xlab = "Number of Paternal Meioses", 
	   ylab = "Mutation Rate",
       ylim = c(0.00E-004, 12.00E-004))

```
```r
#plot das regressões linear (Fig 5A e Fig5B)
library("ggpubr")
library(ggplot2)
variant_age_md<-read.csv("age_md_parental.csv",header = TRUE,sep = ";",dec = ".")
  p.var.age.md.control<-ggplot(variant_age_md, aes(Age_Control, MD_Control, shape=Parental_Control, colour=Parental_Control, fill=Parental_Control)) +
  geom_smooth(method="lm") +
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"))
  )+
  geom_point(size=3) +
  theme_bw() + 
  xlab("Parental Age") +
  ylab("Mutation count") +
  expand_limits(y=0) +
  scale_x_continuous(limits=c(10, 60),breaks = seq(10, 60, by = 10)) +
  scale_y_continuous(limits=c(0, 1500),breaks = seq(0, 1500, by = 250))

#plot de regressão: Dose vs Frequencia de DM
dfdadosgerais<-read.csv("dados_gerais_caso_controle.csv",header = TRUE,sep = ";",dec = ".")
  
  plmdosefrqdm<-ggplot(dfdadosgerais, aes(Dose, Freq_DM, colour=Dose, fill=Dose)) +
      geom_smooth(method="lm") +
      geom_point(size=3) +
      theme_bw() + 
      xlab("Absorbed Dose (Gy)") +
      ylab("Frequency of Mendelian Deviation") 

#plot ratio age VS ratio md (Figu 2B; Gao)
dfdadosgerais<-read.csv("dados_gerais_caso_controle.csv",header = TRUE,sep = ";",dec = ".")
dfDadosGeraisControl<-dfdadosgerais %>% 
                     filter(Dose == 0)
rangeFMAgeControl <- factor(dfDadosGeraisControl$Escala_F_M_Ages)
rangeMFAgeControl <- factor(dfDadosGeraisControl$Escala_M_F_Ages)
rangeFMAgeCase <- factor(dfDadosGeraisCaso$Escala_F_M_Ages)
rangeMFAgeCase <- factor(dfDadosGeraisCaso$Escala_M_F_Ages)

#control
p.ratio.age.md.control <- ggplot(dfDadosGeraisControl, aes(x = Razao_F_M_ages, y = Freq_DM, shape=rangeFMAgeControl, colour= rangeFMAgeControl, fill=rangeFMAgeControl)) +
    geom_point(size=3) +
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~")))+
    scale_colour_manual(values = c("red","purple")) 
p.ratio.age.md.control +
        scale_y_continuous(limits=c(0.0,3.0 ),breaks = seq(0.5, 3.0, by = 0.5)) +
        scale_x_continuous(limits=c(0.0,0.0020),breaks = seq(0.0, 0.0020, by = 0.005)) +
        labs(
            x = "Ratio Paternal/Maternal Age - Control",
            y = "Frequency Paternal/Maternal Mutation - Control"            
        )
#case
p.ratio.age.md.case <- ggplot(dfDadosGeraisCaso, aes(x = Razao_F_M_ages, y = Freq_DM, shape=rangeFMAgeCase, colour= rangeFMAgeCase, fill=rangeFMAgeCase)) +
    geom_point(size=3) +
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~")))+
    scale_colour_manual(values = c("pink","blue")) 
p.ratio.age.md.case +
        labs(
            x = "Ratio Paternal/Maternal Age - Case",
            y = "Frequency Paternal/Maternal Mutation - Case"            
        )

```
```r
#plot facet_wrap to variants from group
dfdadosgerais<-read.csv("dados_gerais_caso_controle.csv",header = TRUE,sep = ";",dec = ".")
dfVariants <- dfdadosgerais[c(2,18,22,26,30,34,38)]
# Transform the data into long format
# Put all variables in the same column except `group`, the grouping variable
dfVariants.pivot <- dfVariants %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfVariants.pivot %>% sample_n(30)
variables.labs <- c("C>A", "C>G", "C>T","T>A", "T>C", "T>G")
names(variables.labs) <- c("Total_C_A", "Total_C_G", "Total_C_T","Total_T_A", "Total_T_C", "Total_T_G")

pClassAge<-ggplot(dfVariants.pivot, aes(x=Group, y=value, shape=Group, colour= Group, fill=Group)) + 
                    geom_bar(stat="identity") +
                    facet_grid(. ~ variables, labeller = labeller(variables = variables.labs)) +
                    theme(strip.text = element_text(face="bold", size=rel(1.5)),
                    strip.background = element_rect(fill="lightblue", colour="black",
                    size=1))

#paternal
dfVariantsPat <- dfdadosgerais[c(2,19,23,27,31,35,39)]
dfVariants.pivot.pat <- dfVariantsPat %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfVariants.pivot.pat %>% sample_n(30)
variables.labs <- c("C>A", "C>G", "C>T","T>A", "T>C", "T>G")
names(variables.labs) <- c("Paternal_C_A", "Paternal_C_G", "Paternal_C_T","Paternal_T_A", "Paternal_T_C", "Paternal_T_G")
pClassAgePat<-ggplot(dfVariants.pivot.pat, aes(x=Group, y=value)) + 
                    geom_bar(stat="identity") +
                    scale_fill_manual(values = c("black","orange")) +
                    facet_grid(. ~ variables, labeller = labeller(variables = variables.labs)) +
                    theme(strip.text = element_text(face="bold", size=rel(1.5)),
                    strip.background = element_rect(fill="lightblue", colour="black",
                    size=1))
#maternal
dfVariantsMat <- dfdadosgerais[c(2,20,24,28,32,36,40)]
dfVariants.pivot.mat <- dfVariantsMat %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfVariants.pivot.pat %>% sample_n(30)
variables.labs <- c("C>A", "C>G", "C>T","T>A", "T>C", "T>G")
names(variables.labs) <- c("Maternal_C_A", "Maternal_C_G", "Maternal_C_T","Maternal_T_A", "Maternal_T_C", "Maternal_T_G")
pClassAgeMat<-ggplot(dfVariants.pivot.mat, aes(x=Group, y=value, fill=Group)) + 
                    geom_bar(stat="identity") +
                    scale_fill_manual(values = c("seagreen4","slategray3")) +
                    facet_grid(. ~ variables, labeller = labeller(variables = variables.labs)) +
                    theme(strip.text = element_text(face="bold", size=rel(1.5)),
                    strip.background = element_rect(fill="lightblue", colour="black",
                    size=1))



```

#Pairewise t-test
pairwise.nummeiose<-pairwise.t.test(anova.nummeiosepat$num.meiose.paterna, anova.nummeiosepat$group,
                 p.adjust.method = "BH")
```

```r
#plot scatter mendelian deviation vs parental
dfDMAgeParental<-read.csv("dados_dm_age_parental.csv",header = TRUE,sep = ";",dec = ".")

#control
p.DM.Age.Parental.control<-ggplot(dfDMAgeParental, aes(x=Age_Control, y=MD_Control, shape=Parental_Control, colour= Parental_Case, fill=Parental_Case)) +
                            geom_point(size = 3) + 
                            facet_grid(. ~ Parental_Control) +
                            theme(strip.text = element_text(face="bold", size=rel(1.5)),
                            strip.background = element_rect(fill="lightblue", colour="black",
                            size=1)) +
                            scale_y_continuous(limits=c(0,1500),breaks = seq(0, 1500, by = 500)) +
                            labs(
                                x = "Parental Age - Control",
                                y = "Number of Mendelian Deviation Parental - Control"            
                            )
#case
p.DM.Age.Parental.case<-ggplot(dfDMAgeParental, aes(x=Age_Case, y=MD_Case, shape=Parental_Case, colour= Parental_Case, fill=Parental_Case)) +
                            geom_point(size=3) +
                            facet_grid(. ~ Parental_Case) +
                            theme(strip.text = element_text(face="bold", size=rel(1.5)),
                            strip.background = element_rect(fill="lightblue", colour="black",
                            size=1)) +
                            scale_y_continuous(limits=c(0,1500),breaks = seq(0, 1500, by = 500)) +
                            labs(
                                x = "Parental Age - Case",
                                y = "Number of Mendelian Deviation Parental - Case"            
                            )
```
```r


```


```r
library(cluster)
library(fpc)
#cluster
cls.age.alelo.pai<-read.table("dataset_pca_age_alelos_pai.txt",header = TRUE,sep = "\t",dec = ".")
df.cls.age.alelo.pai <- cls.age.alelo.pai[, -1] # without known classification 
df.cls.age.alelo.pai.x <- df.cls.age.alelo.pai[, -1]
# Kmeans clustre analysis
clust.age.alelo.pai <- kmeans(df.cls.age.alelo.pai.x, centers=2)	
# More complex
clusplot.age.alelo.pai<- clusplot(df.cls.age.alelo.pai, clust.age.alelo.pai$cluster, 
										main = 'Cluster solution: Number of Mutation Deviation Found in the Father for Alleles vs Age',
										color=TRUE, 
										shade=TRUE,
										labels=5, 
										lines=0)

cls.age.alelo.mae<-read.table("dataset_pca_age_alelos_mae.txt",header = TRUE,sep = "\t",dec = ".")
df.cls.age.alelo.mae.x <- cls.age.alelo.mae[, -1] # without known classification 
# Kmeans clustre analysis
clust.age.alelo.mae <- kmeans(df.cls.age.alelo.mae.x, centers=2)	
# More complex
clusplot.age.alelo.mae<- clusplot(df.cls.age.alelo.mae, clust.age.alelo.mae$cluster, 
										main = 'Cluster solution: Number of Mutation Deviation Found in the Mother for Alleles vs Age',
										color=TRUE, 
										shade=TRUE,
										labels=5, 
										lines=0)
```

```r
# MULTIPLE T-TEST IN R FOR DIFFERENT VARIABLES
# Load required R packages
library(tidyverse)
library(rstatix)
library(ggpubr)
variantes<-read.csv("dataset_variantes_progenitores.csv",header = TRUE,sep = ";",dec = ".")
dfTestt <- variantes[c(4:9)]
# Transform the data into long format
# Put all variables in the same column except `group`, the grouping variable
dfTestt.long <- dfTestt %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfTestt.long %>% sample_n(30)
# Run multiple T-tests
stat.test <- dfTestt.long %>%
  group_by(variables) %>%
  t_test(value ~ Group) %>%
  adjust_pvalue(method = "BH") %>%
  add_significance()
stat.test
# Create multi-panel Boxplots with t-test p-values
# Create the plot
pTestTVariante <- ggboxplot(
  dfTestt.long, x = "Group", y = "value", ylab = "Number of Mutation Deviation"
  fill = "Group", palette = "npg", legend = "none",
  ggtheme = theme_pubr(border = TRUE)
  ) +
  facet_wrap(~variables)
# Add statistical test p-values
stat.test <- stat.test %>% add_xy_position(x = "Group")
stat.test$p.scient <- format(stat.test$p.adj, scientific = TRUE, digits=3)
pTestTVariante + stat_pvalue_manual(stat.test, label = "p.scient")+
   scale_y_continuous(expand = expansion(mult = c(0.05, 0.15)))
```
```r
variant_sex_pat<-read.csv("variantes_progenitores_sexo_paterna.csv",header = TRUE,sep = ";",dec = ".")
dfVariantsPat <- variant_sex_pat[c(2:8)]
# Transform the data into long format
# Put all variables in the same column except `group`, the grouping variable
dfVariant.long.pat <- dfVariantsPat %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfVariant.long.pat %>% sample_n(30)
# Run multiple T-tests
stat.test.pat <- dfVariant.long.pat %>%
  group_by(variables) %>%
  t_test(value ~ Group) %>%
  adjust_pvalue(method = "BH") %>%
  add_significance()
stat.test.pat
# Create multi-panel Boxplots with t-test p-values
# Create the plot
pVariantSexPat <- ggboxplot(dfVariant.long.pat, x = "Group", y = "value", ylab = "Variant of SNPs With Paternal Origin",
  fill = "Group", palette = "RdBu", legend = "none",
  ggtheme = theme_pubr(border = TRUE)
  ) +
  facet_wrap(~variables)
# Add statistical test p-values
stat.test.pat <- stat.test.pat %>% add_xy_position(x = "Group")
pVariantSexPat + stat_pvalue_manual(stat.test.pat, label = "p.adj.signif", tip.length = 0.01)

variantes_progenitores_sexo_mat.csv
```
```r
variant_sex_mat<-read.csv("variantes_progenitores_sexo_mat.csv",header = TRUE,sep = ";",dec = ".")
# Change point shapes and colors
pmat<-ggplot(variant_sex_mat, aes(x=Family, y=AC, shape=factor(Group)))
pmat + geom_point(aes(colour = factor(Group)), size = 4) + 
    geom_point(colour = "grey90", size = 1.5)

# plot bar
dfVariantsMat <- variant_sex_mat[c(2:8)]
# Transform the data into long format
# Put all variables in the same column except `group`, the grouping variable
dfVariant.long.mat <- dfVariantsMat %>%
  pivot_longer(-Group, names_to = "variables", values_to = "value")
dfVariant.long.mat %>% sample_n(30)

pmatbar<-ggdotchart(dfVariant.long.mat, x = "Group", y ="variables",
           color = "color", palette = "jco", size = 3, 
           add = "segment", 
           add.params = list(color = "lightgray", size = 1.5),
           position = position_dodge(0.3),
           ggtheme = theme_pubclean()
           )

pmatfracao<-ggplot(variant_fracao, aes(x=Age, y=Fracao, shape=factor(Progenitor)))
pmatfracao + 
    geom_point(aes(colour = factor(Progenitor)), size = 4) + 
    geom_smooth(method=lm, se=FALSE, fullrange=TRUE)+
    theme_classic()
# Use brewer color palettes
pmatfracao+scale_color_brewer(palette="Dark2")

```

```r


#regression poisson: age VS fraction Age P/M
modelRegrPoisson<-glm(formula = Age ~ Fracao + Progenitor, family = poisson, data = variant_fracao)
summary(modelRegrPoisson)
modelRegrPoissonAge<-glm(formula = Age ~ AC + AG + AT + CG + CT + GT, family = poisson, data= variant_progenitor_age)
summary(modelRegrPoissonAge)

#plot MD VS Age with multiples regression linear (Fig 2A; Gao)
variant_age_md<-read.csv("age_md_parental.csv",header = TRUE,sep = ";",dec = ".")
p.var.age.md.control<-ggplot(variant_age_md, aes(Age_Control, MD_Control, shape=Parental_Control, colour=Parental_Control, fill=Parental_Control)) +
  geom_smooth(method="lm") +
  geom_point(size=3) +
  theme_bw() + 
  xlab("Parental Age") +
  ylab("Mutation count") +
  expand_limits(y=0) +
  scale_x_continuous(limits=c(10, 60),breaks = seq(10, 60, by = 10)) +
  scale_y_continuous(limits=c(0, 1500),breaks = seq(0, 1500, by = 250))
#Group Case
p.var.age.md.case<-ggplot(variant_age_md, aes(Age_Case, MD_Case, shape=Parental_Case, colour=Parental_Case, fill=Parental_Case)) +
  geom_smooth(method="lm") +
  geom_point(size=3) +
  theme_bw() + 
  xlab("Parental Age") +
  ylab("Mutation count") +
  expand_limits(y=0) +
  scale_x_continuous(limits=c(10, 60),breaks = seq(10, 60, by = 10)) +
  scale_y_continuous(limits=c(0, 1500),breaks = seq(0, 1500, by = 250))



#plot ratio age VS ratio md (Figu 2B; Gao)

ratio_age_md<-read.csv("ratio_age_md.csv",header = TRUE,sep = ";",dec = ".")
rangeFMControl <- factor(ratio_age_md$RangeFM_Control)
rangeMFControl <- factor(ratio_age_md$RangeMF_Control)
rangeFMCase <- factor(ratio_age_md$RangeFM_Case)
rangeMFCase <- factor(ratio_age_md$RangeMF_Case)

p.ratio.age.md.control <- ggplot(ratio_age_md, aes(x = RatioAgeFM_Control, y = RadioMDFM_Control, shape=rangeFMControl, colour= rangeFMControl, fill=rangeFMControl)) +
    geom_point(size=3) +
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    scale_colour_manual(values = c("red","purple")) +
    scale_y_continuous(limits=c(0.50, 2.0),breaks = seq(0.50, 2.0, by = 0.25))
p.ratio.age.md.control +
        labs(
            x = "Ratio Paternal/Maternal Age - Control",
            y = "Ratio Paternal/Maternal Mutation - Control"            
        )

p.ratio.age.md.case <- ggplot(ratio_age_md, aes(x = RatioAgeFM_Case, y = RadioMDFM_Case, shape=rangeFMCase, colour= rangeFMCase, fill=rangeFMCase)) +
    geom_point(size=3) +    
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    scale_colour_manual(values = c("green","black")) +
    scale_y_continuous(limits=c(0.50, 2.0),breaks = seq(0.50, 2.0, by = 0.25))
p.ratio.age.md.case +
        labs(
            x = "Ratio Paternal/Maternal Age - Case",
            y = "Ratio Paternal/Maternal Mutation - Case"            
        )

p.ratio.expo.case <- ggplot(ratio_expo_pat, aes(x = RatioAgeFM, y = RatioDMFM)) +
    geom_point(size=3) +    
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    scale_colour_manual(values = c("green","black"))
p.ratio.expo.case +
        labs(
            x = "Ratio Paternal/Maternal Age - Case",
            y = "Ratio Paternal/Maternal Mutation - Case"            
        )

p.ratio.expo.case.mat <- ggplot(ratio_expo_mat, aes(x = RatioAgeMF, y = RatioDMMF)) +
    geom_point(size=3) +    
    stat_smooth(method = "lm", fill = "grey97", size = 2, alpha = 1, se = FALSE) +
    scale_colour_manual(values = c("green","black"))
p.ratio.expo.case.mat +
        labs(
            x = "Ratio Maternal/Paternal Age - Case",
            y = "Ratio Maternal/Paternal Mutation - Case"            
        )
# plot ratio MD father / MD mother VS Age (Paternal and Maternal) (Fig 2C)
library("ggpubr")
library(ggplot2)
ratio_cel_md<-read.csv("ratio_md_parental.csv",header = TRUE,sep = ";",dec = ".")

p.cel.pat.control<-ggplot(ratio_cel_md,aes(x=AgeFatherControl, y=Ratio_CelMDFM_Control)) + 
  geom_point(shape=19, color="black")+
  geom_smooth(method=lm, linetype="dashed", 
             color="darkred", fill="green", level=0.95)+
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"))
  )+
  labs(title="Group Control: Paternal Age vs Radio Mendelian Deviation: Father/Mother",
       x="Paternal Age", y = "Paternal-to-Maternal Ratio")

p.cel.pat.case<-ggplot(ratio_cel_md,aes(x=AgeFatherCase, y=Ratio_CelMDFM_Case)) + 
  geom_point(shape=19, color="black")+
  geom_smooth(method=lm, linetype="dashed", 
             color="darkblue", fill="gray", level=0.95)+
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"))
  )+
  scale_y_continuous(limits=c(5, 30),breaks = seq(5, 30, by = 5)) +
  labs(title="Group Case: Paternal Age vs Radio Mendelian Deviation: Father/Mother",
       x="Paternal Age", y = "Paternal-to-Maternal Ratio")

p.cel.mat.control<-ggplot(ratio_cel_md,aes(x=AgeMotherControl, y=Ratio_CelMDFM_Control)) + 
  geom_point(shape=21)+
  geom_smooth(method=lm, linetype="dashed", 
             color="blue", fill="orange", level=0.95)+
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"))
  )+
  labs(title="Group Control: Maternal Age vs Radio Mendelian Deviation: Father/Mother",
       x="Maternal Age", y = "Paternal-to-Maternal Ratio")

p.cel.mat.case<-ggplot(ratio_cel_md,aes(x=AgeMotherCase, y=Ratio_CelMDFM_Case)) + 
  geom_point(shape=13, color="brown")+
  geom_smooth(method=lm, linetype="dashed", 
             color="red", fill="purple", level=0.95)+
  stat_regline_equation(
    aes(label =  paste(..eq.label.., ..rr.label.., sep = "~~~~"))
  )+
  labs(title="Group Case: Maternal Age vs Radio Mendelian Deviation: Father/Mother",
       x="Maternal Age", y = "Paternal-to-Maternal Ratio")

lm_mat<-lm(AgeMother ~ RatioMDPM, data = ratio_cel_md)
lm_pat<-lm(AgeFather ~ RatioMDPM, data = ratio_cel_md)

#plot MD VS Age with multiples regression linear
p.var.sex.ratio<-ggplot(variant_sex_ratio, aes(AgeParental, RatioPM, colour=RangeRatio, fill=RangeRatio)) +
      geom_smooth(method="lm") +
      geom_point(size=3) +
      theme_bw() + 
      xlab("Parental Age") +
      ylab("Ratio of paternal to maternal ages") +
      expand_limits(y=0) +
      scale_x_continuous(limits=c(10, 60),breaks = seq(10, 60, by = 10))

```