Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:52328 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbcEYQaU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 12:30:20 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 33B8063297
	for <linux-watchdog@vger.kernel.org>; Wed, 25 May 2016 16:20:37 +0000 (UTC)
From: Brian Boylston <brian.boylston@hpe.com>
To: linux-watchdog@vger.kernel.org
Cc: Brian Boylston <brian.boylston@hpe.com>
Subject: [PATCH v2 0/2] watchdog: hpwdt: update HPE maintainer
Date: Wed, 25 May 2016 11:19:23 -0500
Message-Id: <20160525161923.3307-1-brian.boylston@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Update the HPE maintainer of hpwdt.

Patch 2/2 in this series applies on top of:
[PATCH V4] watchdog: hpwdt: Adjust documentation to match latest kernel module parameters
which I think is already in linux-watchdog-next.

Changes in v2:
Addressed feedback from Guenter:
 - Add an entry to MAINTAINERS for hpwdt
 - Remove email addresses from hpwdt.txt

Brian Boylston (2):
  MAINTAINERS: add entry for HPE watchdog driver
  watchdog: hpwdt: remove email address from doc

 Documentation/watchdog/hpwdt.txt | 5 ++---
 MAINTAINERS                      | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.8.3

