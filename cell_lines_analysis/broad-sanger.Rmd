# Broad vs. Sanger Cell Line IDs

#### Ariel Balter

#### 30 May, 2022 

# DepMap Project

Broad and Sanger are both part of the DepMap project.

## Sanger

Sanger has a web page for its [DepMap
Models](https://depmap.sanger.ac.uk/programmes/#models)

Under this section is a link to the [Cell Model
Passports](https://cellmodelpassports.sanger.ac.uk/) section which

> provides a single location where information on Sanger DepMap cell
> models is available in a user-friendly environment.

Cell Model Passports has a [download
page](https://cellmodelpassports.sanger.ac.uk/downloads) which provides

> Stable
> [link](https://cog.sanger.ac.uk/cmp/download/model_list_latest.csv.gz)
> that always points to the latest version.

## Broad

Broad hosts data for the DepMap project at a dedicated portal:

<https://depmap.org/portal/download/>

Broad also has a seemingly-related project called the \[Cancer Cell Line
Encyclopedia (CCLE)\](<https://sites.broadinstitute.org/ccle>. The [CCLE
Datasets page](https://sites.broadinstitute.org/ccle/datasets) has a
link for an annotated list of cell lines, however, that link is dead.
The link for Processed Data leads to the DepMap download portal.

That portal lists a file called
[*sample_info.csv*](https://ndownloader.figshare.com/files/35020903)
which could very well be the annotated cell line information.

# Download Sanger Model List

``` r
model_list = 
  read_csv("https://cog.sanger.ac.uk/cmp/download/model_list_latest.csv.gz") %>% 
  select(
    sanger_model_id = model_id,
    depmap_id = BROAD_ID,
    sanger_sample_id = sample_id,
    sanger_patient_id = patient_id,
    model_type,
    cell_line_name = model_name,
    ccle_id = CCLE_ID,
    tissue,
    cancer_type,
    cancer_subtype = cancer_type_detail,
    sample_site
  )
```

    Rows: 1984 Columns: 51
    -- Column specification -----------------------------------------------
    Delimiter: ","
    chr (36): model_id, model_name, synonyms, model_type, growth_proper...
    dbl  (7): pmed, mutational_burden, ploidy, age_at_sampling, samplin...
    lgl  (8): mutation_data, methylation_data, expression_data, cnv_dat...

    i Use `spec()` to retrieve the full column specification for this data.
    i Specify the column types or set `show_col_types = FALSE` to quiet this message.

# Download BROAD DepMap "Sample Info"

``` r
sample_info = 
  read_csv("https://ndownloader.figshare.com/files/35020903") %>% 
  select(
    depmap_id = DepMap_ID,
    sanger_model_id = Sanger_Model_ID,
    ccle_id = CCLE_Name,
    cell_line_name,
    stripped_cell_line_name,
    tissue = sample_collection_site,
    cancer_type = primary_disease,
    cancer_subtype = Subtype,
    lineage,
    lineage_subtype
    )
```

    Rows: 1840 Columns: 29
    -- Column specification -----------------------------------------------
    Delimiter: ","
    chr (27): DepMap_ID, cell_line_name, stripped_cell_line_name, CCLE_...
    dbl  (2): COSMICID, WTSI_Master_Cell_ID

    i Use `spec()` to retrieve the full column specification for this data.
    i Specify the column types or set `show_col_types = FALSE` to quiet this message.


# Joined

``` r
joined  = full_join(
  sample_info,
  model_list,
  by = c("sanger_model_id", "depmap_id"),
  suffix = c("_broad", "_sanger")
)

sorted_colnames = 
  colnames(joined) %>% 
  sort() %>% 
  setdiff(., c("sanger_model_id", "depmap_id")) %>% 
  c(c("sanger_model_id", "depmap_id"), .)

joined = joined %>% select(!!sorted_colnames)
```

# Some Counts

``` r
joined %>% 
  mutate(
    has_depmap_id = !is.na(depmap_id),
    has_sanger_id = !is.na(sanger_model_id)
  ) %>% 
  count(has_depmap_id, has_sanger_id) %>% 
  kable()
```

  has_depmap_id   has_sanger_id        n
  --------------- --------------- ------
  FALSE           TRUE               269
  TRUE            FALSE              687
  TRUE            TRUE              1730

``` r
joined %>% 
  mutate(
    has_depmap_id = !is.na(depmap_id),
    has_sanger_id = !is.na(sanger_model_id)
  ) %>% 
  group_by(model_type) %>% 
  count(has_depmap_id, has_sanger_id) %>% 
  kable()
```

  model_type   has_depmap_id   has_sanger_id        n
  ------------ --------------- --------------- ------
  Cell Line    FALSE           TRUE               195
  Cell Line    TRUE            TRUE              1715
  Organoid     FALSE           TRUE                74
  NA           TRUE            FALSE              687
  NA           TRUE            TRUE                15

``` r
joined %>% 
  mutate(
    has_depmap_id = !is.na(depmap_id),
    has_sanger_id = !is.na(sanger_model_id),
    has_ccle_id_broad = !is.na(ccle_id_broad),
    has_ccle_id_sanger = !is.na(ccle_id_sanger),
    has_cell_line_name_broad = !is.na(cell_line_name_broad),
    has_cell_line_name_sanger = !is.na(cell_line_name_sanger)
  ) %>% 
  count(has_depmap_id, has_sanger_id, has_ccle_id_broad, has_ccle_id_sanger, has_cell_line_name_broad, has_cell_line_name_sanger) %>% 
  arrange(!has_depmap_id, !has_sanger_id, !has_ccle_id_broad, !has_ccle_id_sanger, !has_cell_line_name_broad, !has_cell_line_name_sanger) %>% 
  kable()
```

  --------------------------------------------------------------------------------------------------------------------------------------
  has_depmap_id   has_sanger_id   has_ccle_id_broad   has_ccle_id_sanger   has_cell_line_name_broad   has_cell_line_name_sanger        n
  --------------- --------------- ------------------- -------------------- -------------------------- --------------------------- ------
  TRUE            TRUE            TRUE                TRUE                 TRUE                       TRUE                          1108

  TRUE            TRUE            TRUE                TRUE                 FALSE                      TRUE                            28

  TRUE            TRUE            TRUE                FALSE                TRUE                       TRUE                             2

  TRUE            TRUE            TRUE                FALSE                TRUE                       FALSE                           14

  TRUE            TRUE            TRUE                FALSE                FALSE                      FALSE                            1

  TRUE            TRUE            FALSE               TRUE                 FALSE                      TRUE                           575

  TRUE            TRUE            FALSE               FALSE                FALSE                      TRUE                             2

  TRUE            FALSE           TRUE                FALSE                TRUE                       FALSE                          620

  TRUE            FALSE           TRUE                FALSE                FALSE                      FALSE                           63

  TRUE            FALSE           FALSE               FALSE                TRUE                       FALSE                            4

  FALSE           TRUE            FALSE               TRUE                 FALSE                      TRUE                             1

  FALSE           TRUE            FALSE               FALSE                FALSE                      TRUE                           268
  --------------------------------------------------------------------------------------------------------------------------------------

