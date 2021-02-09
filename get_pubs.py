from pymed import PubMed
pubmed = PubMed(tool="PubMedSearcher", email="christopher.oldmeadow@hmri.org.au")

## PUT YOUR SEARCH TERM HERE ##
search_term = "Christopher Oldmeadow[AU] OR Chris Oldmeadow[AU] "
results = pubmed.query(search_term, max_results=500)
articleList = []
articleInfo = []

for article in results:
# Print the type of object we've found (can be either PubMedBookArticle or PubMedArticle).
# We need to convert it to dictionary with available function
    articleDict = article.toDict()
    articleList.append(articleDict)

# Generate list of dict records which will hold all article details that could be fetch from PUBMED API
for article in articleList:
#Sometimes article['pubmed_id'] contains list separated with comma - take first pubmedId in that list - thats article pubmedId
    pubmedId = article['pubmed_id'].partition('\n')[0]
    # Append article info to dictionary 
    articleInfo.append({u'pubmed_id':pubmedId,
                       u'title':article['title'],
                       u'keywords':article['keywords'],
                       u'journal':article['journal'],
                       u'doi':article['doi'],
                       u'publication_date':article['publication_date'], 
                       u'authors':article['authors']})

# Generate Pandas DataFrame from list of dictionaries
articlesPD = pd.DataFrame.from_dict(articleInfo)
export_csv = df.to_csv (r'C:\Users\YourUsernam\Desktop\export_dataframe.csv', index = None, header=True) 

#Print first 10 rows of dataframe
print(articlesPD.head(10))
