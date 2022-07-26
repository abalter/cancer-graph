# GDSC to BigQuery ETL

## Download
- Download the data and fix enough problems to be able to save it in TSV files. 
- Data comes in CSV, TSV, and XLSX files from different places on the GDSC website. 
- Some is pretty messed up and needs TLC before it can be saved (for instance making 
  headers match the columns, fixing array data, etc.)
- Some XLSX files have multiple sheets. One has a sheet with three tables on it.
- **NOTE:** I set two variables `eval_r = [TRUE|FALSE]` and `eval_sh = [TRUE|FALSE]`
  in a chunk near the top. Some chunks will execute based on those switches. I used
  this so I can control whether or not to download the bulk data from GDSC which
  takes a long time at my bandwidth. The rest of the operations (doing some things
  with that data, and downloading smaller data) will still run with `eval_sh = FALSE`.

## Harmonize
- Have all columns with same data have the same name. For instance _tissue_ vs _tissue_type_ vs _GDSC.Desc.1_
- Combine files for individual TCGA projects into a single file with _tcga_cancer_name_ as a column. Only when
  this doesn't make the file huge.
- In some cases alter data values. For instance, instead of _is_mutated_ being [0,1], make it 
  [_mutated_, _not_mutated_]. This is an opinionated choice on my part. I try to give all data
  values meaningful names because "Explicit is better than implicit," "Readability Counts," and 
  "If you have to guess, then it's bad." (Loosely taken from The Zen of Python). Also, it makes
  having well-labeled graphs in R much easier.

## Upload to BigQuery
- Use schema table to generate BigQuery schema as BigRquery `bq_field` objects. 

  Some information I've been able to gather from different parts of 
  GDSC website and documentation. Some I just put in my own words. Some I don't 
  know. Some statistical results could be described by reading the papers carefully 
  and using text from them. I don't want to take away all of the next person's fun, 
  so I'm leaving those as an exercise for the reader (as we say in physics).
- Loop through harmonized data and upload to BigQuery.



