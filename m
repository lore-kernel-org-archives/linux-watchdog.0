Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:52311 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbcEYQaU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 12:30:20 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 266BB62D03
	for <linux-watchdog@vger.kernel.org>; Wed, 25 May 2016 16:21:24 +0000 (UTC)
From: Brian Boylston <brian.boylston@hpe.com>
To: linux-watchdog@vger.kernel.org
Cc: Brian Boylston <brian.boylston@hpe.com>
Subject: [PATCH v2 2/2] watchdog: hpwdt: remove email address from doc
Date: Wed, 25 May 2016 11:20:15 -0500
Message-Id: <20160525162015.3442-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove Tom's email address from the documentation

Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
---
 Documentation/watchdog/hpwdt.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index a40398c..7a9f635 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -1,9 +1,9 @@
-Last reviewed: 04/04/2016
+Last reviewed: 05/20/2016
 
                      HPE iLO NMI Watchdog Driver
               NMI sourcing for iLO based ProLiant Servers
                      Documentation and Driver by
-              Thomas Mingarelli <thomas.mingarelli@hpe.com>
+                         Thomas Mingarelli
 
  The HPE iLO NMI Watchdog driver is a kernel module that provides basic
  watchdog functionality and the added benefit of NMI sourcing. Both the
@@ -95,4 +95,3 @@ Last reviewed: 04/04/2016
 
 
  -- Tom Mingarelli
-    (thomas.mingarelli@hpe.com)
-- 
2.8.3

