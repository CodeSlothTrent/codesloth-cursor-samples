# Elasticsearch

Thin tribal cache for Elasticsearch questions. Prefer these summaries, then follow the linked Code Sloth posts and Elastic docs.

## Quick facts

- Elasticsearch is a distributed search and analytics engine; mappings define how fields are indexed and queried.
- `keyword` fields typically index a single token for exact match, sorting, and aggregations; `text` fields are analyzed for full-text search.
- Related mapping families covered on Code Sloth include nested objects, flattened fields, custom analyzers, and keyword aggregations (terms, composite, adjacency matrix, cardinality).

## Official docs (start here)

| Topic | Canonical link |
|-------|----------------|
| Keyword field | https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/keyword |
| Text field | https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/text |
| Nested field | https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/nested |
| Flattened field | https://www.elastic.co/docs/reference/elasticsearch/mapping-reference/flattened |
| Terms aggregation | https://www.elastic.co/docs/reference/aggregations/search-aggregations-bucket-terms-aggregation |
| Cardinality aggregation | https://www.elastic.co/docs/reference/aggregations/search-aggregations-metrics-cardinality-aggregation |
| Analyzers | https://www.elastic.co/docs/reference/text-analysis |

## Code Sloth tribal knowledge (examples already written)

| Article | URL |
|---------|-----|
| Keyword field data type deep dive | https://codesloth.blog/keyword-field-data-type-deep-dive/ |
| Querying the keyword field | https://codesloth.blog/tutorial-querying-the-keyword-field-data-type/ |
| Sorting the keyword field | https://codesloth.blog/tutorial-sorting-the-keyword-field-data-type/ |
| Aggregating the keyword field | https://codesloth.blog/tutorial-aggregating-the-keyword-field-data-type/ |
| Cardinality on keyword | https://codesloth.blog/tutorial-opensearch-elasticsearch-cardinality-aggregation-on-keyword/ |
| Elasticsearch vs OpenSearch | https://codesloth.blog/opensearch-vs-elasticsearch-deciding-which-is-best/ |
| Elasticsearch on Windows | https://codesloth.blog/installing-elasticsearch-and-running-on-windows/ |
| Elasticsearch in Docker | https://codesloth.blog/elasticsearch-docker-tutorial/ |
| Elasticsearch GUI / Head extension | https://codesloth.blog/elasticsearch-gui-tutorial/ · https://codesloth.blog/tutorial-elasticsearch-head-chrome-extension-deep-dive/ |
