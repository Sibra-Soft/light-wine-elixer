INSERT INTO `_user_roles` VALUES (1, 'Administrators');
INSERT INTO `_users` VALUES (2, 'admin', '0f57035e9d62c86b6ae3bbe6edc5c8653cb89c550571a357c2665efc2f392be804309dc7561cc5e8f8557812de7109a81cd8808fc178659a0abfb7426e72e296', 1, NULL, '1', '2022-3-18 11:03:18', NULL, 'Administrator', NULL);

INSERT INTO `site_routes` VALUES ('9', 'index', '/', '9', '1', 'Hello world', null, '1', 'template-link', null, 'GET', null, null, null, '2022-07-15 12:35:01', null);

INSERT INTO `site_templates` VALUES (1, 'Templates', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 0, 1);
INSERT INTO `site_templates` VALUES (2, 'Scripts', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 0, 1);
INSERT INTO `site_templates` VALUES (3, 'Stylesheets', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 0, 1);
INSERT INTO `site_templates` VALUES (4, 'Mail Templates', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 0, 1);
INSERT INTO `site_templates` VALUES (5, 'Queries', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 0, 1);
INSERT INTO `site_templates` VALUES (6, 'Service Modules', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 25, 1);
INSERT INTO `site_templates` VALUES (7, 'Workers', 'folder', NULL, NULL, NULL, '2022-1-21 12:23:36', NULL, 'System', NULL, NULL, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 0, 30, 1);
INSERT INTO `site_templates` VALUES (8, 'masterpage', 'html', NULL, NULL, NULL, '2021-12-22 18:57:37', NULL, 'System', NULL, 1, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 1, 0, 1);
INSERT INTO `site_templates` VALUES (9, 'index', 'html', NULL, NULL, NULL, '2022-3-18 11:06:16', NULL, 'System', NULL, 1, NULL, NULL, NULL, 0, '1004,1005,1006,1007', 1, 0, 1);

INSERT INTO `site_template_versioning` VALUES (8, 1, '2022-3-18 11:50:36', '<!DOCTYPE html>\r\n<html lang=\"nl\">\r\n   <head>\r\n	  <meta charset=\"UTF-8\">\r\n\r\n	  <title>{{$pageTitle}}</title>\r\n\r\n	  {{$pageJavascript}}\r\n   </head>\r\n   <body>\r\n	  {{$pageContent}}\r\n\r\n	  {{$pageScripts}}\r\n	  {{$pageStylesheets}}\r\n   </body>\r\n</html>', NULL);
INSERT INTO `site_template_versioning` VALUES (9, 1, '2022-3-18 11:50:53', '<h1>Hello World</h1>', NULL);