dir="large_files/hugo"

mkdir -p $dir

curl \
	-o ${dir}/hugo_complete_set.tsv \
	http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/hgnc_complete_set.txt
