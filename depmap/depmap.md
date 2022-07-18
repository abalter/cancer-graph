---
editor_options: 
  markdown: 
    wrap: 72
---

i'm browsing around and struggling to find what we want, at least in a
processed format that does not require us to analyze the underlying
data. many of the experiments in DepMap have done some form of either
gene knockout (crispr), knock down (shRNA), or small molecule inhibition
(i think that is primarily the prism project) across huundreds of cell
lines. similar to GDSC where they have ANOVA results of compounds, their
targets, and biomarkers (which represent genomics alterations like copy
number or mutations) which are sensitizing to the compound

 - ultimately what we would like is a matrix of genes versus biomarkers
(which could be mutated genes for example) where let's say the columns
are genes that were knocked down/out (crispr and/or shRNA) and the rows
are biomarkers/genes that are the sensitizing alterations in the cell
lines that were screened.

the underlying data are all in the depmap portal in terms of cell line
dependencies for knock out/down as well as genomic characterization of
mutations for each cell line based on the CCLE project. in the same way
we are creating cohorts of mutated and wildtype samples in TCGA for each
gene in each cancer, and statistically assessing changes in expression
in all other genes between these cohorts, for the DepMap data we want to
create cohorts in CCLE for each gene and each cancer type, and
statistically assess changes in viability based on knock out/down of all
other genes between these cohorts.

GDSC did that analysis for us, and i have to imagine DepMap did too - i
just can't find it at the moment. is that making sense? can you browse
around or contact folks there to track down such an analysis - they must
have done this!






summary looks pretty good ... at least i think i still stand behind my prior statements :slightly_smiling_face:

Q2 - what i mean by 'target aspect' is that in the model you described you do not explicitly call out targets as part of the model and what we are trying to predict. in your model, the target is essentially implicit in your drug repurposing ML goal - however, in general for the project we have not only a drug repurposing goal but also a novel target identification/prediction goal. that target, whether completely new or being repurposed, is represented in our graph almost always as a gene (in reality the protein product of that gene, but we are treating genes and the protein products as being synonymous at this time). there can/should be edges (i.e., relationships) between drugs or compounds and their targets. our model, as you know, must have some cancer type representation to it. how exactly we implement that is still TBD i believe, and there are many ways to represent cancer-specific aspects in the graph - i don't have a strong opinion of how we go about doing that, as long as it is accounted for when it comes to ML.

Q3 - correlation may enhance the model's ability to learn, but it may also be misleading in the drug-cancer-genetic feature basis that you describe. for example, vemurafenib is effective in BRAF mutant melanomas but not in BRAF mutant colorectal cancers.

https://www.cancernetwork.com/view/why-braf-mutated-colorectal-cancers-dont-respond-braf-inhibitors

in this case, the genetic feature and drug are the same, but we will hopefully have other informative cancer-specific features that distinguish between cancers where it would work or not (and maybe those other features come from TCGA, for example - or Achilles, GDSCC, or ... who knows?).

Q4 - that is one of the most important questions for which we do not yet know the answer. in a very qualitative sense have seen through years of browsing these data in graphs that there is reason to believe we may have informative features, and the more heterogeneous our data the more chance i believe we give ourselves for success. but that is the crux of the project - are we incorporating features that have discriminatory ability to distinguish targets from everything else?

Q5a - the anecdote i listed above is one such example i am aware of , and there may be a review article or such that has additional negatives, but i think it is safe to say there is no such comprehensive pairwise evaluation of drugs and cancers, given similar genetic features.  that said, there are 'basket trials' which have only very recently been run and are along these same lines. you should learn about those in principle and see if any of them have begun to report results on drugs, genetic features, and cancers. this could be the recent clinical trial piece that makes our project so timely and feasible to have better knowledge of positives and negative.

Q5b - yes, spend at least some time on positive:unlabeled learning. it will definitely be an important concept to understand for this project. as a review, i enjoyed the following:



https://link.springer.com/article/10.1007/s10994-020-05877-5

https://www.cancernetwork.com/view/why-braf-mutated-colorectal-cancers-dont-respond-braf-inhibitors
