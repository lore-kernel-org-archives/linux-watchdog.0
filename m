Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp484.redcondor.net ([208.80.204.84]:52031 "EHLO
        smtp484.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbcJPLAk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Oct 2016 07:00:40 -0400
Received: from astoria.ccjclearline.com ([64.235.106.9])
          by smtp484.redcondor.net ({c48374e7-08df-40d9-a0de-96cc9883a037})
          via TCP (outbound) with ESMTPS id 20161016105017163_0484
          for <linux-watchdog@vger.kernel.org>;
          Sun, 16 Oct 2016 10:50:17 +0000
Received: from [174.118.92.171] (port=58894 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1bvj18-0006Ne-Ri
        for linux-watchdog@vger.kernel.org; Sun, 16 Oct 2016 06:50:10 -0400
Date: Sun, 16 Oct 2016 06:49:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: Remove misleading word "legacy" for
 /dev/watchdog
Message-ID: <alpine.LFD.2.20.1610160645550.19356@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The word "legacy" should not be used for the special file
/dev/watchdog, as that file is still essential for watchdog
operations.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i expressed my reservations about use of the word "legacy" here:

https://lists.kernelnewbies.org/pipermail/kernelnewbies/2016-October/017054.html

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 32930a0..0cc5ab8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -891,7 +891,7 @@ static struct miscdevice watchdog_miscdev = {
  *	@wdd: watchdog device
  *	@devno: character device number
  *
- *	Register a watchdog character device including handling the legacy
+ *	Register a watchdog character device including handling the
  *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
  *	thus we set it up like that.
  */
@@ -968,7 +968,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
  *	watchdog_cdev_unregister: unregister watchdog character device
  *	@watchdog: watchdog device
  *
- *	Unregister watchdog character device and if needed the legacy
+ *	Unregister watchdog character device and if needed the
  *	/dev/watchdog device.
  */

@@ -1002,7 +1002,7 @@ static struct class watchdog_class = {
  *	watchdog_dev_register: register a watchdog device
  *	@wdd: watchdog device
  *
- *	Register a watchdog device including handling the legacy
+ *	Register a watchdog device including handling the
  *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
  *	thus we set it up like that.
  */
@@ -1040,7 +1040,7 @@ int watchdog_dev_register(struct watchdog_device *wdd)
  *	watchdog_dev_unregister: unregister a watchdog device
  *	@watchdog: watchdog device
  *
- *	Unregister watchdog device and if needed the legacy
+ *	Unregister watchdog device and if needed the
  *	/dev/watchdog device.
  */


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

