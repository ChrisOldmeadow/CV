library(easyPubMed)
my_query <- '(Christopher Oldmeadow[AU] OR Chris Oldmeadow[AU] '
my_entrez_id <- get_pubmed_ids(my_query)
my_papers <- fetch_pubmed_data(my_entrez_id)
titles <- custom_grep(my_papers, "ArticleTitle", "char")

