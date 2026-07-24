# OpenSearch

Thin tribal cache for OpenSearch questions. Prefer these summaries, then follow the linked Code Sloth posts and OpenSearch docs.

## Quick facts

- OpenSearch is an open-source search and analytics suite API-compatible with many Elasticsearch patterns, with its own docs and client libraries.
- Field-type stories on Code Sloth mirror ES closely for `keyword` / `text`, and diverge in naming for some types (for example OpenSearch `flat_object` vs Elasticsearch `flattened`).
- Java samples (`opensearch-java`) and HTTP Dashboards examples are the usual teaching vehicle on the blog.

## Official docs (start here)

| Topic | Canonical link |
|-------|----------------|
| Keyword field | https://docs.opensearch.org/latest/mappings/supported-field-types/keyword/ |
| Text field | https://docs.opensearch.org/latest/mappings/supported-field-types/text/ |
| Nested field | https://docs.opensearch.org/latest/mappings/supported-field-types/nested/ |
| Flat object | https://docs.opensearch.org/latest/mappings/supported-field-types/flat-object/ |
| Terms aggregations | https://docs.opensearch.org/latest/aggregations/bucket/terms/ |
| Composite aggregations | https://docs.opensearch.org/latest/aggregations/bucket/composite/ |
| Adjacency matrix | https://docs.opensearch.org/latest/aggregations/bucket/adjacency-matrix/ |
| Text analysis / analyzers | https://docs.opensearch.org/latest/analyzing-text/ |

## Code Sloth tribal knowledge (examples already written)

| Article | URL |
|---------|-----|
| Getting started with OpenSearch in Java | https://codesloth.blog/getting-started-with-opensearch-in-java-with-codesloth-code-samples/ |
| Indexing data in OpenSearch | https://codesloth.blog/indexing-data-in-opensearch/ |
| OpenSearch in Docker | https://codesloth.blog/opensearch-docker-tutorial/ |
| Keyword field in Java | https://codesloth.blog/opensearch-keyword-field-in-java/ |
| Indexing the text field | https://codesloth.blog/tutorial-indexing-the-opensearch-text-field-data-type/ |
| Custom analyzer | https://codesloth.blog/tutorial-creating-an-opensearch-custom-analyzer/ |
| Nested field type in Java | https://codesloth.blog/opensearch-nested-field-type-java/ |
| Flattened / flat object in Java | https://codesloth.blog/opensearch-flattened-field-type-in-java/ |
| Flattened numeric range queries | https://codesloth.blog/opensearch-flattened-field-numeric-range-queries/ |
| Flattened date range queries | https://codesloth.blog/opensearch-flattened-field-date-range-queries/ |
| Keyword terms aggregation | https://codesloth.blog/tutorial-opensearch-keyword-terms-aggregation/ |
| Terms include/exclude | https://codesloth.blog/tutorial-opensearch-terms-aggregation-include-exclude-parameters/ |
| Keyword composite aggregation | https://codesloth.blog/tutorial-opensearch-keyword-composite-aggregation/ |
| Keyword adjacency matrix | https://codesloth.blog/tutorial-opensearch-keyword-adjacency-matrix-aggregation/ |
| Troubleshooting OpenSearch HTTP | https://codesloth.blog/troubleshooting-opensearch-http/ |
| Too many nested clauses | https://codesloth.blog/troubleshooting-too-many-nested-clauses/ |
| OpenSearch vs Elasticsearch | https://codesloth.blog/opensearch-vs-elasticsearch-deciding-which-is-best/ |

## Answering guidance

- Prefer OpenSearch doc URLs when the user said OpenSearch; prefer Elastic URLs when they said Elasticsearch; load both files when they ask about differences.
- For flat vs nested modeling questions, point at the flat object / flattened posts and call out the naming difference vs Elasticsearch.
- Route search-engine choice questions to the comparison post rather than re-litigating the fork history at length.
