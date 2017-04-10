-- Table 1
BEGIN;

  delete  from landing.udmd_unileversolutions_custom_data_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_custom_data_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_custom_data_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_custom_data_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- add all tables in landing
-- have each step in a separate transaction (begin/commit)

-- Table 2
BEGIN;

  delete  from landing.com_snowplowanalytics_snowplow_add_to_cart_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_snowplowanalytics_snowplow_add_to_cart_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_snowplowanalytics_snowplow_add_to_cart_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_snowplowanalytics_snowplow_add_to_cart_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 3
BEGIN;

  delete  from landing.com_snowplowanalytics_snowplow_remove_from_cart_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_snowplowanalytics_snowplow_remove_from_cart_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_snowplowanalytics_snowplow_remove_from_cart_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_snowplowanalytics_snowplow_remove_from_cart_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 4
BEGIN;

delete  from landing.org_w3_performance_timing_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.org_w3_performance_timing_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.org_w3_performance_timing_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.org_w3_performance_timing_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 5
BEGIN;

delete  from landing.udmd_unileversolutions_componentvideo_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_componentvideo_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_componentvideo_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_componentvideo_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 6
BEGIN;

delete  from landing.udmd_unileversolutions_page_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_page_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_page_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_page_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 7
BEGIN;

delete  from landing.udmd_unileversolutions_promotion_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_promotion_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_promotion_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_promotion_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 8
BEGIN;

delete  from landing.udmd_unileversolutions_product_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_product_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_product_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_product_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 9
BEGIN;

delete  from landing.org_ietf_http_cookie_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.org_ietf_http_cookie_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.org_ietf_http_cookie_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.org_ietf_http_cookie_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 10
BEGIN;

delete  from landing.com_google_analytics_enhanced_ecommerce_action_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_google_analytics_enhanced_ecommerce_action_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_google_analytics_enhanced_ecommerce_action_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_google_analytics_enhanced_ecommerce_action_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 11
BEGIN;

delete  from landing.com_google_analytics_enhanced_ecommerce_action_field_object_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_google_analytics_enhanced_ecommerce_action_field_object_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_google_analytics_enhanced_ecommerce_action_field_object_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_google_analytics_enhanced_ecommerce_action_field_object_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;

-- Table 12
BEGIN;

 delete  from landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 13
BEGIN;

 delete  from landing.com_google_analytics_enhanced_ecommerce_product_field_object_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_google_analytics_enhanced_ecommerce_product_field_object_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_google_analytics_enhanced_ecommerce_product_field_object_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_google_analytics_enhanced_ecommerce_product_field_object_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 14
BEGIN;

 delete  from landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Tabe 15
BEGIN;

  delete  from landing.com_snowplowanalytics_snowplow_screen_view_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_snowplowanalytics_snowplow_screen_view_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_snowplowanalytics_snowplow_screen_view_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_snowplowanalytics_snowplow_screen_view_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 16
BEGIN;

delete  from landing.udmd_unileversolutions_event_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.udmd_unileversolutions_event_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.udmd_unileversolutions_event_1 where root_id in
( SELECT event_id
FROM landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c JOIN landing.events e
ON e.event_id = c.root_id
AND e.collector_tstamp = c.root_tstamp
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot')) ;

--Delete all Ip address in page_urlhost data
delete  from landing.udmd_unileversolutions_event_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 17
BEGIN;
-- Delete with following parameters
delete  from landing.com_snowplowanalytics_snowplow_ua_parser_context_1 where root_id in
(
SELECT root_id
FROM landing.events e JOIN landing.com_snowplowanalytics_snowplow_ua_parser_context_1 c
ON e.event_id = c.root_id AND e.collector_tstamp = c.root_tstamp
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%' );

--Delete for useragent_family
delete from landing.com_snowplowanalytics_snowplow_ua_parser_context_1
WHERE useragent_family IN ('Googlebot', 'PingdomBot', 'PhantomJS', 'Slurp', 'BingPreview', 'YandexBot', 'FacebookBot') ;

--Delete all Ip address in page_urlhost data
delete  from landing.com_snowplowanalytics_snowplow_ua_parser_context_1 where root_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');

COMMIT;


-- Table 18
BEGIN;

-- Delete with following parameters
delete  from landing.events
WHERE page_urlhost like  '%amazon.com%'
or page_urlhost like '%.app%'                           or page_urlhost like '%.trclient%'                                                      or page_urlhost like '%dev%'
or page_urlhost like '%local%'                          or page_urlhost like '%demo%'                                                           or page_urlhost like  '%client%'
or page_urlhost like '%origin-%'                        or page_urlhost like '%preview-%'                                                       or page_urlhost like  '%staging%'
or page_urlhost like '%test%'                           or page_urlhost like '%stage%'                                                          or page_urlhost like '%qa.unileversolutions.com%'
or page_urlhost like '%qa%'                                     or page_urlhost like '%web%'                                                            or page_urlhost like '%uat.unileversolutions.com%'
or page_urlhost like '%.info%'                          or page_urlhost like '%.net%'                                                           or page_urlhost like '%akamai%'
or page_urlhost like '%.org%'                           or page_urlhost like '%html%'                                                           or page_urlhost like '%server%'
or page_urlhost like '%emulator%'                       or page_urlhost like '%proxy%'
or page_urlhost like '%pitch%'                          or page_urlhost like '%bing%'                                                           or page_urlhost like '%eat.com%'
or page_urlhost like '%yahoo.com%'                      or page_urlhost like '%preview%'
or page_urlhost like '%console%'                        or br_family = 'Robot/Spider'                                                           or useragent similar to '%(bot|crawl|slurp|spider|archiv|spinn|sniff|seo|audit|survey|pingdom|worm|capture|
(browser|screen)shots|analyz|index|thumb|check|facebook|YandexBot|Twitterbot|a_archiver|facebookexternalhit|Bingbot|Googlebot|Baiduspider|360(Spider|User-agent)|semalt)%';

--Delete all Ip address in page_urlhost data
delete  from landing.events where event_id in (
select event_id from (select event_id ,REGEXP_SUBSTR(page_urlhost,'[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}.[\\d]{1,3}$') a from landing.events)
where a != '' or a != ' ');
