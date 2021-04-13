# Mitochondrial Variants
This code was designed to create a table of mitochondrial variants, their associated amino acid changes (if any), which features these changes effect, predicted consequences (with SIFT and PolyPhen scores), associated diseases, and the frequency of these variants in the general population. Sources for this information include Ensembl Variant Effect Predictor, MitoMap, and GenomeNet.

## Code:

* revision_code.R — used to create the final output file, rev_table.txt

## Input Files:

* mito_reference.txt — reference mitochondrial genome, dowloaded from https://www.genome.jp/dbget-bin/www_bget?-f+refseq+NC_012920

* VEP_results.txt — results after running Ensembl Variant Effect Predictor (VEP), http://feb2021.archive.ensembl.org/Homo_sapiens/Tools/VEP/Results?tl=7nVTR4F7LvanKnbJ-7217453

* disease.cgi.txt — information on mitochondrial variant/disease associations, downloaded from https://www.mitomap.org/foswiki/bin/view/MITOMAP/Resources

* polymorphisms.cgi.txt — information on mitochondrial variants, downloaded from https://www.mitomap.org/foswiki/bin/view/MITOMAP/Resources

## Output Files:

* variant_table.txt — all possible variants in the mitochondrial genome (single substitution, no insertion or deletion). Used as input for VEP

* VEP_redu.txt — intermediate table, prior to integration with MitoMap information

* rev_table.txt — final output table

## Final Output Description:

1. Position — 1-16569 bp. You will notice that there are not the expected 49,708 rows but instead a few hundred more. This is because sometimes more than one gene is associated with the same position and therefore it receives multiple lines. This shouldn’t be an issue.
2. Reference — reference nucleotide from https://www.genome.jp/dbget-bin/www_bget?-f+refseq+NC_012920
3. Variant — each possible variant, 3 for all positions with the exception of 3,107, which has 4
4. Consequence — (VEP) predicted consequence of the variant. The following two graphs are part of the VEP output and give an idea of the breakdown for all 49,708 input variants
5. Symbol — (VEP) gene symbol
6. Gene — (VEP) Ensembl gene ID
7. Feature type — (VEP) type of feature affected: transcript, regulatory feature, or motif feature
8. Feature — (VEP) Ensembl transcript ID or other identifier, based on feature type
9. Biotype — (VEP) type of transcript or regulatory feature: protein coding, tRNA, or rRNA. More are present in VEP but not associated with mitochondria
10. Amino acids — (VEP) any amino acid changes that occur due to the variant
11. Codons — (VEP) if an amino acid change occurs, this is shows which codon was changed, with the affected nucleotide in the capital letter
12. SIFT — (VEP) SIFT prediction score for whether an amino acid change will affect protein function (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC168916/)
13. PolyPhen — (VEP) PolyPhen prediction score for whether an amino acid change will affect protein function (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4480630/)
14. Homoplasmy* — (MitoMap)
15. Heteroplasmy* — (MitoMap)
16. Disease* — (MitoMap) diseases associated with a particular variant
17. Status* — (MitoMap) has this variant been reported or confirmed?
18. GB Count — (MitoMap) GenBank count
19. GB Frequency — (MitoMap) GenBank frequency. See the following for more information on columns 18 and 19 (https://www.mitomap.org/MITOMAP/GBFreqInfo)
 
### Notes for the (*) indicated columns (from MitoMap):
* LHON — Leber Hereditary Optic Neuropathy
* MM — Mitochondrial Myopathy
* AD — Alzeimer's Disease
* LIMM — Lethal Infantile Mitochondrial Myopathy
* ADPD — Alzeimer's Disease and Parkinsons's Disease
* MMC — Maternal Myopathy and Cardiomyopathy
* NARP — Neurogenic muscle weakness, Ataxia, and Retinitis Pigmentosa; alternate phenotype at this locus is reported as Leigh Disease
* FICP — Fatal Infantile Cardiomyopathy Plus, a MELAS-associated cardiomyopathy
* MELAS — Mitochondrial Encephalomyopathy, Lactic Acidosis, and Stroke-like episodes
* LDYT — Leber's hereditary optic neuropathy and DYsTonia
* MERRF — Myoclonic Epilepsy and Ragged Red Muscle Fibers
* MHCM — Maternally inherited Hypertrophic CardioMyopathy
* CPEO — Chronic Progressive External Ophthalmoplegia
* KSS — Kearns Sayre Syndrome
* DM – Diabetes Mellitus
* DMDF — Diabetes Mellitus + DeaFness
* CIPO — Chronic Intestinal Pseudoobstruction with myopathy and Ophthalmoplegia
* DEAF — Maternally inherited DEAFness or aminoglycoside-induced DEAFness
* PEM — Progressive encephalopathy
* SNHL — SensoriNeural Hearing Loss

** Homoplasmy = pure mutant mtDNAs.

** Heteroplasmy = mixture of mutant and normal mtDNAs.

** nd = not determined.

** "Reported" status indicates that one or more publications have considered the mutation as possibly pathologic. This is not an assignment of pathogenicity by MITOMAP but is a report of literature. Previously, mutations with this status were termed "Prov" (provisional).

** "Cfrm"(confirmed) status indicates that at least two or more independent laboratories have published reports on the pathogenicity of a specific mutation. These mutations are generally accepted by the mitochondrial research community as being pathogenic. A status of "Cfrm" is not an assignment of pathogenicity by MITOMAP but is a report of published literature. Researchers and clinicians are cautioned that additional data and/or analysis may still be necessary to confirm the pathological significance of some of these mutations.

** "P.M." (point mutation / polymorphism) status indicates that some published reports have determined the mutation to be a non-pathogenic polymorphism.
 
