
- init:
    assign:
    - project_id: ${PROJECT_ID}
    - query: "${QUERY}"

- getTables:
    call: googleapis.bigquery.v2.jobs.query
    args:
        projectId: $${project_id}
        body:
            query: $${query}
            useLegacySql: false
    result: table_list

- dynamic:
    for:
      value: number
      range: $${[0, len(table_list.rows)]}
      steps:
      - logTable:
          call: sys.log
          args:
              text: $${"Running query for table " + table_list.rows[number].f[0].v}
      - runQueryPerTable:
          call: googleapis.bigquery.v2.jobs.query
          args:
              projectId: $${project_id}
              body:
                  useLegacySql: false
                  useQueryCache: false
                  timeoutMs: 30000
                  query: $${
                      "CREATE TABLE dynamic_workflows." + table_list.rows[number].f[0].v + " AS (
                      SELECT TITLE, SUM(views) view_count
                      FROM `bigquery-samples.wikipedia_pageviews." + table_list.rows[number].f[0].v + "`
                      WHERE LENGTH(TITLE) > 10
                      GROUP BY TITLE
                      ORDER BY SUM(VIEWS) DESC
                      LIMIT 100);"
                      }
          result: queryResult

- output:
    return: $${table_list.rows[0].f[0].v}
