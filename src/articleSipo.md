```r
dfDMAge<-read.csv("dataset_sipo_dm_age.csv",header = TRUE,sep = ";",dec = ".")
dfDMAgeGroupA<-read.csv("dataset_sipo_dm_age_group_a.csv",header = TRUE,sep = ";",dec = ".")
dfDMAgeGroupB<-read.csv("dataset_sipo_dm_age_group_b.csv",header = TRUE,sep = ";",dec = ".")
```

```r
##Fluxo do algoritmo: SIPO
library(DiagrammeR)
mermaid("
graph TD
  A(SIPO)-->B>Genotyping Data Files - ChAS]
  B---C((Filters))
  C---D((Assay Variables))
  D-->E[Mother's Calling Base']
  E-->F[Father's Calling Base']
  F-->G[Offspring's Calling Base']
  G-->H(Mendelian deviationsian)
  H-->I{Parental Origin}
  I-->J(With Inference)
  I-->L(Without Inference)
  J-->K(Lowest Confidence)
  K-->M>Output: -SNPs with MD -Parental Origin -Type of Substitution]
  I-->M
")
```
```r
##Group A
meanA <- round(mean(dfDMAgeGroupA$MD), digits = 2)
sdA <- round(sd(dfDMAgeGroupA$MD), digits = 2)
medianaA <- round(median(dfDMAgeGroupA$MD), digits = 2)
table(meanA, sdA, medianaA)
print(table(meanA, sdA, medianaA), zero.print = ".")

##Group B
meanB <- round(mean(dfDMAgeGroupB$MD), digits = 2)
sdB <- round(sd(dfDMAgeGroupB$MD), digits = 2)
medianaB <- round(median(dfDMAgeGroupB$MD), digits = 2)
table(meanB, sdB, medianaB)
print(table(meanB, sdB, medianaB), zero.print = ".")

##Plot Box-Plot para numero de DM: A X B
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
  title = "Groups",
  titlefont = f1,
  showticklabels = TRUE,
  tickangle = 0,
  tickfont = f2,
  exponentformat = "E"
)
bpDM<-plot_ly(dfDMAgeGroupA, y = ~dfDMAgeGroupA$MD, type = "box",name="Group A", boxpoints = "all", jitter = 0.1, pointpos = -1.9)  %>%
	add_trace(dfDMAgeGroupB, y = ~dfDMAgeGroupB$MD, type = "box",name="Group B", boxpoints = "all", jitter = 0.1, pointpos = -1.9) %>%
    layout(xaxis = b, yaxis = a, title = "Nº Mendelian Deviation")
```
```r
##Checando as premissas:
  #Normalidade e Variância
  ## 1. Testes de normalidade
  Parâmetros:
  xbA <- mean(dfDMAgeGroupA$MD) # média
  xbB <- mean(dfDMAgeGroupB$MD) # média
  meA <- median(dfDMAgeGroupA$MD) # mediana
  meB <- median(dfDMAgeGroupB$MD) # mediana
  sxA <- round(sd(dfDMAgeGroupA$MD), digits = 2) # desvio padrão
  sxB <- round(sd(dfDMAgeGroupB$MD), digits = 2) # desvio padrão
  cat("\n Média amostral do Grupo A =", xbA, "\n Desvio padrão amostral do Grupo A =", sxA, "\n Mediana amostral do Grupo A =", meA)
  cat("\n Média amostral do Grupo B =", xbB, "\n Desvio padrão amostral do Grupo B =", sxB, "\n Mediana amostral do Grupo B =", meB)

##Teste de hipótese
ttestHipo<-t.test(dfDMAgeGroupA$MD,dfDMAgeGroupB$MD) 
ttestHipo

##Plot da Normalidade
##Basic qq plot
par(mfrow=c(1, 2))
qplot(sample = MD, data = dfDMAgeGroupA)+
	stat_qq() +
	stat_qq_line() +
	labs(title="Plot Q-Q: Mendelian Deviation - Group A",
       y = "Nº of Mendelian Deviation")

qplot(sample = MD, data = dfDMAgeGroupB)+
	stat_qq() +
	stat_qq_line() +
	labs(title="Plot Q-Q: Mendelian Deviation - Group B",
       y = "Nº of Mendelian Deviation")

##Hipóteses do teste de Normalidade:  
##H0: Distribuição é Normal  
##H1: Distribuição não é Normal  
##p >> 0,05 → podemos assumir que os dados sigam a distribuição Normal 
## 2. Gráfico QQ com envelope Grupo A
nA<-length(dfDMAgeGroupA$MD)
xbA <- mean(dfDMAgeGroupA$MD) # média
sxA <- round(sd(dfDMAgeGroupA$MD), digits = 2) # desvio padrão
cat("\n n =", nA)
nSimA <- 100 # Número de simulações
confA <- 0.95 # Coef. de confiança
# Dados simulados ~ normal
dadosSimA <- matrix(rnorm(nA * nSimA, mean = xbA, sd = sxA), nrow = nA)
dadosSimA <- apply(dadosSimA, 2, sort)
# Limites da banda e média
infSupA <- apply(dadosSimA, 1, quantile, probs = c((1 - confA) / 2,
 (1 + confA) / 2))
xbSimA <- rowMeans(dadosSimA)
# Gráfico
faixayA <- range(dfDMAgeGroupA$MD, dadosSimA)
qqA <- qqnorm(dfDMAgeGroupA$MD, main = "Plot Q-Q: Mendelian Deviation - Group A", xlab = "Quantile", pch = 20,
 ylab = "MD - Group A", ylim = faixayA)
eixoxA <- sort(qqA$x)
lines(eixoxA, xbSimA)
lines(eixoxA, infSupA[1,])
lines(eixoxA, infSupA[2,])
dadosSimA <- matrix(rnorm(nA * nSimA, mean = xbA, sd = sxA), nrow = nA)
dadosSimA <- apply(dadosSimA, 2, sort)

## 2. Gráfico QQ com envelope Grupo A
nB<-length(dfDMAgeGroupB$MD)
xbB <- mean(dfDMAgeGroupB$MD) # média
sxB <- round(sd(dfDMAgeGroupB$MD), digits = 2) # desvio padrão
cat("\n n =", nB)
nSimB <- 100 # Número de simulações
confB <- 0.95 # Coef. de confiança
# Dados simulados ~ normal
dadosSimB <- matrix(rnorm(nB * nSimA, mean = xbB, sd = sxB), nrow = nB)
dadosSimB <- apply(dadosSimB, 2, sort)
# Limites da banda e média
infSupB <- apply(dadosSimB, 1, quantile, probs = c((1 - confB) / 2,
 (1 + confB) / 2))
xbSimB <- rowMeans(dadosSimB)
# Gráfico
faixayB <- range(dfDMAgeGroupB$MD, dadosSimB)
qqB <- qqnorm(dfDMAgeGroupB$MD, main = "Plot Q-Q: Mendelian Deviation - Group B", xlab = "Quantile", pch = 20,
 ylab = "MD - Group B", ylim = faixayB)
eixoxB <- sort(qqB$x)
lines(eixoxB, xbSimB)
lines(eixoxB, infSupB[1,])
lines(eixoxB, infSupB[2,])
dadosSimB <- matrix(rnorm(nB * nSimB, mean = xbB, sd = sxB), nrow = nB)
dadosSimB <- apply(dadosSimB, 2, sort)

```


```r
library(devtools)
library("dplyr")
library(tidyr)
library("ggpubr")
library("gplots")
library("scatterplot3d")
colors <- c("#56B4E9","#E69F00")
dfDMAge<-read.csv("dataset_sipo_dm_age.csv",header = TRUE,sep = ";",dec = ".")
colors <- colors[as.numeric(dfDMAge$Group)]
scatterplot3d(dfDMAge[,2:3], pch = 16, type="h", 
              color=colors, grid=TRUE, box=TRUE)

library(car)
pairs(~MD+Age_Father+Age_Mother,data=dfDMAge,
   main="Simple Scatterplot Matrix")

```
```r
library(dplyr)
# Compute the analysis of variance
res.aov.age <- aov(Age_Father ~ Group, data = dfDMAge)
# Summary of the analysis
summary(res.aov.age)

group_by(dfDMAge, dfDMAge$Group) %>%
  summarise(
    count = n(),
    mean = mean(dfDMAge$Age_Father, na.rm = TRUE),
    sd = sd(Age_Father, na.rm = TRUE)
  )

p.ggline.age<-ggline(dfDMAge, x = "Group", y = "Age_Father", 
       add = c("mean_se", "jitter"), 
       order = c("A", "B"),
       ylab = "Father's Age", xlab = "Group")

#Mother's age
res.aov.age.mo <- aov(Age_Mother ~ Group, data = dfDMAge)
# Summary of the analysis
summary(res.aov.age.mo)

group_by(dfDMAge, dfDMAge$Group) %>%
  summarise(
    count = n(),
    mean = mean(dfDMAge$Age_Mother, na.rm = TRUE),
    sd = sd(Age_Mother, na.rm = TRUE)
  )

p.ggline.age.mo<-ggline(dfDMAge, x = "Group", y = "Age_Mother", 
       add = c("mean_se", "jitter"), 
       order = c("A", "B"),
       ylab = "Mother's Age", xlab = "Group")

library("plotly")
library(magrittr)

y <- c('Unsolved','Inference')
A <- c(5906, 6138)
B <- c(781, 3896)
C <- c(9902, 7884)
data <- data.frame(y, A, B, C)

p.bar <- plot_ly(data, x = ~A, y = ~y, type = 'bar', orientation = 'h', name = 'Group A',
        marker = list(color = 'rgba(246, 78, 139, 0.6)',
                      line = list(color = 'rgba(246, 78, 139, 1.0)',
                                  width = 3)))
p.bar <- p.bar %>% add_trace(x = ~B, name = 'Group B',
            marker = list(color = 'rgba(58, 71, 80, 0.6)',
                          line = list(color = 'rgba(58, 71, 80, 1.0)',
                                      width = 3)))
p.bar <- p.bar %>% add_trace(x = ~C, name = 'Group C',
            marker = list(color = 'rgba(0,0,255,0.3)',
                          line = list(color = 'rgba(0,0,255,0.3)',
                                      width = 3)))
p.bar <- p.bar %>% layout(barmode = 'stack',
         xaxis = list(title = "Number of Mendelian Deviation"),
         yaxis = list(title =""))

p.bar

```

```r

library(ggplot2)
library(ggalt)
library(ggfortify)
theme_set(theme_classic())
# Compute data with principal components ------------------
dfCluster<-read.csv("dataset_sipo_dm_age_group.csv",header = TRUE,sep = ";",dec = ".")
df <- dfCluster[c(5, 6, 9)]
pca_mod <- prcomp(df)  # compute principal components

# Data frame of principal components ----------------------
df_pc <- data.frame(pca_mod$x, Group=dfCluster$group)  # dataframe of principal components
df_pc_a <- df_pc[df_pc$Group == "A", ]  # df for 'A'
df_pc_b <- df_pc[df_pc$Group == "B", ]  # df for 'B'
df_pc_c <- df_pc[df_pc$Group == "C", ]  # df for 'C'

# Plot ----------------------------------------------------
p<-ggplot(df_pc, aes(PC1, PC2, col=Group)) + 
      geom_point(aes(shape=Group), size=2) +   # draw points
      labs(title="SIPO Clustering", 
           subtitle="With principal components PC1 and PC2 as X and Y axis",
           caption="Source: SIPO") + 
      coord_cartesian(xlim = 1.2 * c(min(df_pc$PC1), max(df_pc$PC1)), 
                      ylim = 1.2 * c(min(df_pc$PC2), max(df_pc$PC2))) +   # change axis limits
      geom_encircle(data = df_pc_a, aes(x=PC1, y=PC2)) +   # draw circles
      geom_encircle(data = df_pc_b, aes(x=PC1, y=PC2)) + 
      geom_encircle(data = df_pc_c, aes(x=PC1, y=PC2))

```

```r
library(plotly)
dfAge<-read.csv("dataset_sipo_dm_age_group.csv",header = TRUE,sep = ";",dec = ".")
# Boxplot Violin: Total of the mendelian deviation
fig <- dfAge %>%
  plot_ly(
    x = ~group,
    y = ~dm.total,
    split = ~group,
    type = 'violin',
    box = list(
      visible = T
    ),
    meanline = list(
      visible = T
    )
  ) 

fig <- fig %>%
  layout(
    xaxis = list(
      title = "Group"
    ),
    yaxis = list(
      title = "Total Mendelian Deviation ",
      zeroline = F
    )
  )

fig

# Boxplot Violin: Father's Age
figFatherAge <- dfAge %>%
  plot_ly(
    x = ~group,
    y = ~idade.pai,
    split = ~group,
    type = 'violin',
    box = list(
      visible = T
    ),
    meanline = list(
      visible = T
    )
  ) 

figFatherAge <- figFatherAge %>%
  layout(
    xaxis = list(
      title = "Group"
    ),
    yaxis = list(
      title = "Total Mendelian Deviation ",
      zeroline = F
    )
  )

figFatherAge

```

```r
# MULTIPLE T-TEST IN R FOR DIFFERENT VARIABLES
# Load required R packages
library(tidyverse)
library(rstatix)
library(ggpubr)
dfTest<-read.csv("dataset_sipo_dm_age_group.csv",header = TRUE,sep = ";",dec = ".")
dfTestt <- dfTest[c(4, 5, 9)]


# Transform the data into long format
# Put all variables in the same column except `group`, the grouping variable
dfTestt.long <- dfTestt %>%
  pivot_longer(-group, names_to = "variables", values_to = "value")
dfTestt.long %>% sample_n(5)
# Run multiple T-tests
stat.test <- dfTestt.long %>%
  group_by(variables) %>%
  t_test(value ~ group) %>%
  adjust_pvalue(method = "BH") %>%
  add_significance()
stat.test

# Create multi-panel Boxplots with t-test p-values
# Create the plot
pTestTAge <- ggboxplot(
  dfTestt.long, x = "group", y = "value",
  fill = "group", palette = "npg", legend = "none",
  ggtheme = theme_pubr(border = TRUE)
  ) +
  facet_wrap(~variables)
# Add statistical test p-values
stat.test <- stat.test %>% add_xy_position(x = "Group")
pTestTAge + stat_pvalue_manual(stat.test, label = "p.adj.signif")
```

```r
dfTestDMt <- dfTest[c(8, 9)]
dfTestDMt.long <- dfTestDMt %>%
  pivot_longer(-group, names_to = "variables", values_to = "value")
dfTestDMt.long %>% sample_n(5)
# Run multiple T-tests
stat.test.dm <- dfTestDMt.long %>%
  group_by(variables) %>%
  t_test(value ~ group) %>%
  adjust_pvalue(method = "BH") %>%
  add_significance()
stat.test.dm
# Create multi-panel Boxplots with t-test p-values
# Create the plot
pTestDMT <- ggboxplot(
  dfTestDMt.long, x = "group", y = "value",
  fill = "group", palette = "npg", legend = "none",
  ggtheme = theme_pubr(border = TRUE)
  ) +
  facet_wrap(~variables)


# Box plot
p.boxplot<-boxplot(dm.total ~ group, data = dfGrupoSipo,
        xlab = "Group", ylab = "Desvian Mendelian Total",
        frame = FALSE, col = c("#00AFBB", "#E7B800", "#FC4E07"))		  
		
library("gplots")
plotmeans(dm.total ~ group, data = dfGrupoSipo, frame = FALSE,
          xlab = "Group", ylab = "Desvian Mendelian Total",
          main="Mean Plot with 95% CI") 		
		  
# Compute the analysis of variance
res.aov.dm <- aov(dm.total ~ group, data = dfGrupoSipo)
# Summary of the analysis
summary(res.aov.dm)		  

# Edit from here
x <- which(names(dfGrupoSipo) == "group") # name of grouping variable
y <- which(
  names(dfGrupoSipo) == "dm.total" # names of variables to test
)
method1 <- "anova" # one of "anova" or "kruskal.test"
method2 <- "t.test" # one of "wilcox.test" or "t.test"
my_comparisons <- list(c("A", "B"), c("A", "C"), c("B", "C")) # comparisons for post-hoc tests
# Edit until here


# Edit at your own risk
library(ggpubr)
for (i in y) {
  for (j in x) {
    p <- ggboxplot(dfGrupoSipo,
      x = colnames(dfGrupoSipo[j]), y = colnames(dfGrupoSipo[i]),
      color = colnames(dfGrupoSipo[j]),
      legend = "none",
      palette = "npg",
      add = "jitter"
    )
    print(
      p + stat_compare_means(aes(label = paste0(..method.., ", p-value = ", ..p.format..)),
        method = method1, label.y = max(dfGrupoSipo[, i], na.rm = TRUE)
      )
      + stat_compare_means(comparisons = my_comparisons, method = method2, label = "p.format") # remove if p-value of ANOVA or Kruskal-Wallis test >= alpha
    )
  }
}

# Edit from here
x <- which(names(dfGrupoSipo) == "group") # name of grouping variable
y <- which(
  names(dfGrupoSipo) == "dm.inference" # names of variables to test
)
method1 <- "anova" # one of "anova" or "kruskal.test"
method2 <- "t.test" # one of "wilcox.test" or "t.test"
my_comparisons <- list(c("A", "B"), c("A", "C"), c("B", "C")) # comparisons for post-hoc tests
# Edit until here


# Edit at your own risk
library(ggpubr)
for (i in y) {
  for (j in x) {
    p <- ggboxplot(dfGrupoSipo,
      x = colnames(dfGrupoSipo[j]), y = colnames(dfGrupoSipo[i]),
      color = colnames(dfGrupoSipo[j]),
      legend = "none",
      palette = "npg",
      add = "jitter"
    )
    print(
      p + stat_compare_means(aes(label = paste0(..method.., ", p-value = ", ..p.format..)),
        method = method1, label.y = max(dfGrupoSipo[, i], na.rm = TRUE)
      )
      + stat_compare_means(comparisons = my_comparisons, method = method2, label = "p.format") # remove if p-value of ANOVA or Kruskal-Wallis test >= alpha
    )
  }
}
```

```r

dfGrupoSipo<-read.csv("dataset_sipo_dm_age_group.csv",header = TRUE,sep = ";",dec = ".")
# Edit from here
x <- which(names(dfGrupoSipo) == "group") # name of grouping variable
y <- which(
  names(dfGrupoSipo) == "dm.no.inference" # names of variables to test
)
method1 <- "anova" # one of "anova" or "kruskal.test"
method2 <- "t.test" # one of "wilcox.test" or "t.test"
my_comparisons <- list(c("A", "B"), c("A", "C"), c("B", "C")) # comparisons for post-hoc tests
# Edit until here


# Edit at your own risk
library(ggpubr)
for (i in y) {
  for (j in x) {
    p <- ggboxplot(dfGrupoSipo,
      x = colnames(dfGrupoSipo[j]), y = colnames(dfGrupoSipo[i]),
      color = colnames(dfGrupoSipo[j]),
      legend = "none",
      palette = "npg",
      add = "jitter"
    )
    print(
      p + stat_compare_means(aes(label = paste0(..method.., ", p-value = ", ..p.format..)),
        method = method1, label.y = max(dfGrupoSipo[, i], na.rm = TRUE)
      )
      + stat_compare_means(comparisons = my_comparisons, method = method2, label = "p.format") # remove if p-value of ANOVA or Kruskal-Wallis test >= alpha
    )
  }
}
# Add statistical test p-values
stat.test.dm <- stat.test.dm %>% add_xy_position(x = "group")
pTestDMT + stat_pvalue_manual(stat.test.dm, label = "p")
```
