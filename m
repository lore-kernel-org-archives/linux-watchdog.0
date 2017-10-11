Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:49106 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbdJKRqe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Oct 2017 13:46:34 -0400
Received: by mail-wm0-f43.google.com with SMTP id i124so6805860wmf.3
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Oct 2017 10:46:33 -0700 (PDT)
Message-ID: <1507743991.3486.5.camel@arista.com>
Subject: Lowering the log level in watchdog_dev_register when err==-EBUSY
From: Radu Rendec <rrendec@arista.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Oct 2017 18:46:31 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

In a project I'm working on we have a valid use case where we activate
both the i6300esb and softdog watchdogs. We always activate i6300esb
first (which uses the "legacy" watchdog API) and then softdog. This
gets us two "error" level messages (coming from watchdog_cdev_register)
although softdog falls back to the "new" API and registers its char
device just fine.

Since watchdog_cdev_register/watchdog_dev_register seem to be used only
by watchdog_register_device and the latter always falls back to the
"new" API, I'm thinking about lowering the log level of these messages
when err is -EBUSY. Something along the lines of:

--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -928,11 +928,14 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
                watchdog_miscdev.parent = wdd->parent;
                err = misc_register(&watchdog_miscdev);
                if (err != 0) {
-                       pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
-                               wdd->info->identity, WATCHDOG_MINOR, err);
-                       if (err == -EBUSY)
-                               pr_err("%s: a legacy watchdog module is probably present.\n",
-                                       wdd->info->identity);
+                       if (err == -EBUSY) {
+                               pr_info("%s: cannot register miscdev on minor=%d (err=%d).\n",
+                                               wdd->info->identity, WATCHDOG_MINOR, err);
+                               pr_info("%s: a legacy watchdog module is probably present.\n",
+                                               wdd->info->identity);
+                       } else
+                               pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
+                                       wdd->info->identity, WATCHDOG_MINOR, err);
                        old_wd_data = NULL;
                        kfree(wd_data);
                        return err;

Does this look like a good approach? If not, what would you recommend?
In any case, I want to upstream the change, so better ask first :)

Thanks,
Radu Rendec

