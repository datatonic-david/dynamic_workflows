
- init:
    assign:
    - project_id: ${PROJECT_ID}
    - query: "${QUERY}"

- runQuery:
    call: googleapis.bigquery.v2.jobs.query
    args:
        projectId: $${project_id}
        body:
            query: $${query}
            useLegacySql: false
    result: table_list

- output:
    return: $${table_list}
