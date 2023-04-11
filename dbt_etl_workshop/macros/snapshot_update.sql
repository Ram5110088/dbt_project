
{% macro snapshot_update(snapshot_table, source_table, timestamp,source_schema,target_schema) %}


INSERT INTO {{target_schema}}.{{ snapshot_table }} (
  SELECT
    s.*,
    {{ timestamp }} AS valid_from,
    '9999-12-31 23:59:59' AS valid_to,
    TRUE AS is_current
  FROM {{source_schema}}.{{ source_table }} s
  LEFT JOIN {{target_schema}}.{{ snapshot_table }} t
    ON s.id = t.id
  WHERE t.id IS NULL
);


UPDATE {{target_schema}}.{{ snapshot_table }} t
SET valid_to = {{ timestamp }},
    is_current = FALSE
WHERE EXISTS (
  SELECT 1
  FROM {{source_schema}}.{{ source_table }} s
  WHERE s.id = t.id
    AND (
      {{ source_columns }}) IS DISTINCT FROM
      ({{ target_columns }})
);

{% endmacro %}
