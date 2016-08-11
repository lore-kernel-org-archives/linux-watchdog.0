Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:59426 "EHLO mail.zeus03.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369AbcHKVaY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 17:30:24 -0400
From: Wolfram Sang <wsa-dev@sang-engineering.com>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: don't print error when allocating urb fails
Date: Thu, 11 Aug 2016 23:23:39 +0200
Message-Id: <1470950620-26397-1-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This per-subsystem series is part of a tree wide cleanup. usb_alloc_urb() uses
kmalloc which already prints enough information on failure. So, let's simply
remove those "allocation failed" messages from drivers like we did already for
other -ENOMEM cases. gkh acked this approach when we talked about it at LCJ in
Tokyo a few weeks ago.


Wolfram Sang (1):
  watchdog: pcwd_usb: don't print error when allocating urb fails

 drivers/watchdog/pcwd_usb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.8.1

