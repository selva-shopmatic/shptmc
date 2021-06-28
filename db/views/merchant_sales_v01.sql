 SELECT ((o.tenant_id || '_'::text) || o.id) AS id,
    o.tenant_id AS merchant_id,
    to_timestamp(to_char(
        CASE
            WHEN ((m.home_country)::text = 'IN'::text) THEN timezone('UTC+5:30'::text, o.created_at)
            WHEN ((m.home_country)::text = 'MY'::text) THEN timezone('UTC+8'::text, o.created_at)
            WHEN ((m.home_country)::text = 'SG'::text) THEN timezone('UTC+8'::text, o.created_at)
            WHEN ((m.home_country)::text = 'HK'::text) THEN timezone('UTC+8'::text, o.created_at)
            ELSE (o.created_at)::timestamp with time zone
        END, 'YYYY/MM/DD HH24:MI:SS'::text), 'YYYY/MM/DD HH24:MI:SS'::text) AS order_date,
    o.id AS order_id,
    o.total AS order_value,
        CASE
            WHEN (o.order_type = 0) THEN 'webstore'::text
            WHEN (o.order_type = 1) THEN 'chat'::text
            WHEN (o.order_type = 3) THEN 'webstore'::text
            WHEN (o.order_type = 4) THEN 'chat'::text
            WHEN (o.order_type = 5) THEN 'social'::text
            ELSE NULL::text
        END AS channel,
        CASE
            WHEN (o.order_type = 0) THEN 'webstore'::text
            WHEN (o.order_type = 1) THEN 'pos'::text
            WHEN (o.order_type = 3) THEN 'gspot'::text
            WHEN (o.order_type = 4) THEN 'chat'::text
            WHEN (o.order_type = 5) THEN 'social'::text
            ELSE NULL::text
        END AS order_type
   FROM (orders o
     JOIN merchants m ON ((o.tenant_id = m.id)))
  WHERE ((o.status >= 20) AND (o.created_at >= (CURRENT_DATE - '30 days'::interval day)))
UNION
 SELECT ((mo.tenant_id || '_'::text) || mo.id) AS id,
    mo.tenant_id AS merchant_id,
    to_timestamp(to_char(
        CASE
            WHEN ((m.home_country)::text = 'IN'::text) THEN timezone('UTC+5:30'::text, mo.created_at)
            WHEN ((m.home_country)::text = 'MY'::text) THEN timezone('UTC+8'::text, mo.created_at)
            WHEN ((m.home_country)::text = 'SG'::text) THEN timezone('UTC+8'::text, mo.created_at)
            WHEN ((m.home_country)::text = 'HK'::text) THEN timezone('UTC+8'::text, mo.created_at)
            ELSE (mo.created_at)::timestamp with time zone
        END, 'YYYY/MM/DD HH24:MI:SS'::text), 'YYYY/MM/DD HH24:MI:SS'::text) AS order_date,
    mo.id AS order_id,
    mo.total AS order_value,
    'marketplaces'::text AS channel,
    'marketplaces'::text AS order_type
   FROM (marketplace_orders mo
     JOIN merchants m ON ((mo.tenant_id = m.id)))
  WHERE (mo.external_created_at >= (CURRENT_DATE - '30 days'::interval day));
