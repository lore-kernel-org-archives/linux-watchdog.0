Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30192 "EHLO
	g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcEWNmF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 09:42:05 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id D51561420
	for <linux-watchdog@vger.kernel.org>; Mon, 23 May 2016 13:34:40 +0000 (UTC)
From: Brian Boylston <brian.boylston@hpe.com>
To: linux-watchdog@vger.kernel.org
Cc: Brian Boylston <brian.boylston@hpe.com>
Subject: [PATCH] watchdog: hpwdt: update HPE maintainer
Date: Mon, 23 May 2016 08:33:29 -0500
Message-Id: <20160523133329.10075-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Update the HPE maintainer of the hpwdt driver.

Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
---
This patch applies on top of:
[PATCH V4] watchdog: hpwdt: Adjust documentation to match latest kernel module parameters.
which I think is already in linux-watchdog-next.

 Documentation/watchdog/hpwdt.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/hpwdt.txt
index a40398c..27106ff 100644
--- a/Documentation/watchdog/hpwdt.txt
+++ b/Documentation/watchdog/hpwdt.txt
@@ -1,9 +1,12 @@
-Last reviewed: 04/04/2016
+Last reviewed: 05/20/2016
 
                      HPE iLO NMI Watchdog Driver
               NMI sourcing for iLO based ProLiant Servers
                      Documentation and Driver by
-              Thomas Mingarelli <thomas.mingarelli@hpe.com>
+                         Thomas Mingarelli
+
+                       Currently maintained by
+               Brian Boylston <brian.boylston@hpe.com>
 
  The HPE iLO NMI Watchdog driver is a kernel module that provides basic
  watchdog functionality and the added benefit of NMI sourcing. Both the
@@ -95,4 +98,3 @@ Last reviewed: 04/04/2016
 
 
  -- Tom Mingarelli
-    (thomas.mingarelli@hpe.com)
-- 
2.8.3

