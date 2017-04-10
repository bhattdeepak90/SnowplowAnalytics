-- Copyright (c) 2013-2015 Snowplow Analytics Ltd. All rights reserved.
--
-- This program is licensed to you under the Apache License Version 2.0,
-- and you may not use this file except in compliance with the Apache License Version 2.0.
-- You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the Apache License Version 2.0 is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
--
-- Authors: Yali Sassoon, Christophe Bogaert
-- Copyright: Copyright (c) 2013-2015 Snowplow Analytics Ltd
-- License: Apache License Version 2.0
--
-- Data Model: web-incremental
-- Version: 2.0
--
-- Vacuum:
-- (a) vacuum landing schema
-- (b) vacuum and analyze derived schema
-- (c) vacuum and analyze atomic

-- (a) vacuum landing schema

--VACUUM landing.events;
--VACUUM landing.com_example_context_1; -- add all tables in landing
--VACUUM landing.com_example_unstructured_event_1; -- add all tables in landing
VACUUM landing.events;
VACUUM landing.com_snowplowanalytics_snowplow_add_to_cart_1 ; -- add all tables in atomic
VACUUM landing.com_snowplowanalytics_snowplow_remove_from_cart_1; -- add all tables in atomic
VACUUM  landing.org_w3_performance_timing_1 ;
VACUUM landing.udmd_unileversolutions_custom_data_1;
VACUUM landing.com_snowplowanalytics_snowplow_ua_parser_context_1;
VACUUM landing.udmd_unileversolutions_componentvideo_1 ;
VACUUM landing.udmd_unileversolutions_page_1 ;
VACUUM landing.udmd_unileversolutions_promotion_1 ;
VACUUM landing.udmd_unileversolutions_product_1 ;
VACUUM landing.org_ietf_http_cookie_1 ;
VACUUM landing.com_google_analytics_enhanced_ecommerce_action_1 ;
VACUUM landing.com_google_analytics_enhanced_ecommerce_action_field_object_1 ;
VACUUM landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1 ;
VACUUM landing.com_google_analytics_enhanced_ecommerce_product_field_object_1;
VACUUM landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1;

---analyse
ANALYSE landing.events;
ANALYSE landing.com_snowplowanalytics_snowplow_add_to_cart_1 ; -- add all tables in atomic
ANALYSE landing.com_snowplowanalytics_snowplow_remove_from_cart_1; -- add all tables in atomic
ANALYSE  landing.org_w3_performance_timing_1 ;
ANALYSE landing.udmd_unileversolutions_custom_data_1;
ANALYSE landing.com_snowplowanalytics_snowplow_ua_parser_context_1;
ANALYSE landing.udmd_unileversolutions_componentvideo_1 ;
ANALYSE landing.udmd_unileversolutions_page_1 ;
ANALYSE landing.udmd_unileversolutions_promotion_1 ;
ANALYSE landing.udmd_unileversolutions_product_1 ;
ANALYSE landing.org_ietf_http_cookie_1 ;
ANALYSE landing.com_google_analytics_enhanced_ecommerce_action_1;
ANALYSE landing.com_google_analytics_enhanced_ecommerce_action_field_object_1;
ANALYSE landing.com_google_analytics_enhanced_ecommerce_impression_field_object_1;
ANALYSE landing.com_google_analytics_enhanced_ecommerce_product_field_object_1;
ANALYSE landing.com_google_analytics_enhanced_ecommerce_promo_field_object_1;

