Return-Path: <SRS0=EMH8=S2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B2C10F11
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBEF21773
	for <linux-watchdog@archiver.kernel.org>; Wed, 24 Apr 2019 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfDXPh2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:37:28 -0400
Received: from mail.windriver.com ([147.11.1.11]:52860 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfDXPh2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 Apr 2019 11:37:28 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3OFb1UM002842
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 24 Apr 2019 08:37:01 -0700 (PDT)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 08:37:00 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 77E812E03F1; Wed, 24 Apr 2019 11:37:00 -0400 (EDT)
Date:   Wed, 24 Apr 2019 11:37:00 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly
 non-modular
Message-ID: <20190424153700.GT23044@windriver.com>
References: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
 <1556034515-28792-3-git-send-email-paul.gortmaker@windriver.com>
 <439d89d7-bae6-c5c8-e9bf-5477304bc065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <439d89d7-bae6-c5c8-e9bf-5477304bc065@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

[Re: [PATCH 2/5] watchdog: watchdog_core: make it explicitly non-modular] On 23/04/2019 (Tue 18:22) Guenter Roeck wrote:

> On 4/23/19 8:48 AM, Paul Gortmaker wrote:
> >The Kconfig currently controlling compilation of this code is:
> >
> >config WATCHDOG_CORE
> >        bool "WatchDog Timer Driver Core"
> >
> >...meaning that it currently is not being built as a module by anyone.
> >
> >Lets remove the modular code that is essentially orphaned, so that
> >when reading the driver there is no doubt it is builtin-only.
> >
> >We replace module.h with export.h since the file does export some
> >symbols.  We don't add init.h since the file already has that.
> >
> >We also delete the MODULE_LICENSE tag etc. since all that information
> >is already contained at the top of the file in the comments.
> >
> 
> I must admit that I am not at all happy about this change. While not
> configurable by default, I used tristate a lot (after enabling it
> manually) to test watchdog core code while changing it. It saves a
> lot of time to be able to reload the watchdog core without having
> to reboot the entire system after each change. Removing the ability

I'm confused.  If it is useful, then why not formally make it tristate
so other people can do the same as you do, and nobody is manually making
the change over and over again each time?  I'd support that update.

> to do that just because it is not enabled in the field and just
> to save a few lines of code (and because having modules seems to
> have come out of favor lately) does not make sense to me.

I'd have to say this is a mischaracterization.  Modules are not out of
favour.  A disconnect between the code and Kconfig is out of favour.

Of all the hundred or so(?) of these type patches that have been merged
so far, I have not created a single change with the intent of reduction
in the existing out-of-box mainline support of drivers as modules.

Rather, It is in fact the opposite.  As I said in the 0/5 preamble:

    As always, the option exists for driver authors to convert their
    code to tristate...

...and a lot of drivers are now tristate because the author simply
didn't realize they'd chosen "bool".  We managed to make a new uart
driver get bool ---> tristate conversion just this week, for example.

https://marc.info/?l=linux-serial&m=155602656610079&w=2

> I won't NACK the series outright, but I'll leave it up to Wim as
> the senior maintainer to decide what he wants to do with it.

Yes, the decision is entirely up to you guys, but I just wanted to
clarify once again that this or any one of the other similar changes
are in no way some kind of "attack on modules". Quite the opposite
as you can see in the above thread.

Thanks,
Paul.
--

> 
> Guenter
> 
> >Cc: Wim Van Sebroeck <wim@iguana.be>
> >Cc: Guenter Roeck <linux@roeck-us.net>
> >Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >Cc: linux-watchdog@vger.kernel.org
> >Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >---
> >  drivers/watchdog/watchdog_core.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> >diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> >index eb8fa25f8eb2..f9f88f59d181 100644
> >--- a/drivers/watchdog/watchdog_core.c
> >+++ b/drivers/watchdog/watchdog_core.c
> >@@ -28,7 +28,7 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >-#include <linux/module.h>	/* For EXPORT_SYMBOL/module stuff/... */
> >+#include <linux/export.h>	/* For EXPORT_SYMBOL stuff */
> >  #include <linux/types.h>	/* For standard types */
> >  #include <linux/errno.h>	/* For the -ENODEV/... values */
> >  #include <linux/kernel.h>	/* For printk/panic/... */
> >@@ -359,17 +359,4 @@ static int __init watchdog_init(void)
> >  	watchdog_deferred_registration();
> >  	return 0;
> >  }
> >-
> >-static void __exit watchdog_exit(void)
> >-{
> >-	watchdog_dev_exit();
> >-	ida_destroy(&watchdog_ida);
> >-}
> >-
> >  subsys_initcall_sync(watchdog_init);
> >-module_exit(watchdog_exit);
> >-
> >-MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
> >-MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
> >-MODULE_DESCRIPTION("WatchDog Timer Driver Core");
> >-MODULE_LICENSE("GPL");
> >
> 
