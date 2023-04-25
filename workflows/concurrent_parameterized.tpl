
- init:
    assign:
    - project_id: ${PROJECT_ID}
    - concurrency_limit: ${CONCURRENCY_LIMIT}

- ingestion:
    parallel:
      concurrency_limit: $${concurrency_limit}
      for:
        value: number
        in: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        steps:
          - getTables:
              call: googleapis.bigquery.v2.jobs.query
              args:
                  projectId: $${project_id}
                  body:
                      query: $${
                          "CREATE TABLE dynamic_workflows.parameter_" + number + " AS (
                          SELECT TITLE, SUM(views) view_count
                          FROM `bigquery-samples.wikipedia_pageviews.200802h`
                          WHERE LENGTH(TITLE) > ?
                          GROUP BY TITLE
                          ORDER BY SUM(VIEWS) DESC
                          LIMIT 10);"
                          }
                      queryParameters:
                        parameterValue:
                          value: $${number}
                        parameterType:
                          type: INT64
                      useLegacySql: false
              result: queryResult


