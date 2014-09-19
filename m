Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46881 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaISQVU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Sep 2014 12:21:20 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so234038pdj.19
        for <linux-watchdog@vger.kernel.org>; Fri, 19 Sep 2014 09:21:19 -0700 (PDT)
Date: Fri, 19 Sep 2014 09:21:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janusz =?utf-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog's pm support preffered implementation
Message-ID: <20140919162115.GE30723@roeck-us.net>
References: <54088996.4040500@elproma.com.pl>
 <540C9383.9050307@roeck-us.net>
 <540D02E1.90403@elproma.com.pl>
 <540D1F8F.2080802@roeck-us.net>
 <54196BE2.2010800@elproma.com.pl>
 <541ABD07.5090407@elproma.com.pl>
 <541B5156.803@elproma.com.pl>
 <541B5684.7000809@elproma.com.pl>
 <541B9EF7.4030702@roeck-us.net>
 <541BFB63.3060006@elproma.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <541BFB63.3060006@elproma.com.pl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 19, 2014 at 11:46:11AM +0200, Janusz Użycki wrote:
> 
> W dniu 2014-09-19 05:11, Guenter Roeck pisze:
> >On 09/18/2014 03:02 PM, Janusz Użycki wrote:
> >>Small fix below in the second implementation.
> >>
> >>best regards
> >>Janusz
> >>
> >>W dniu 2014-09-18 23:40, Janusz Użycki pisze:
> >>>Hi again,
> >>>
> >>>This is the second implementation. Which do you prefer?
> >>>
> >This one
> 
> ok
> 
> >
> >>>Subject: [PATCH] stmp3xxx_rtc_wdt: Add suspend/resume PM support
> >>>
> >>>
> >>>Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> >>>---
> >>> drivers/watchdog/stmp3xxx_rtc_wdt.c | 39 +++++++++++++++++++++++
> >>> 1 file changed, 39 insertions(+)
> >>>
> >>>diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> >>>b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> >>>index 3546f03..1946277 100644
> >>>--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> >>>+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> >>>@@ -95,9 +95,48 @@ static int stmp3xxx_wdt_remove(struct
> >>>platform_device *pdev)
> >>>        return 0;
> >>> }
> >>>
> >>>+#ifdef CONFIG_PM_SLEEP
> >>>+/* There is no conflict with rtc/rtc-stmp3xxx.c parent
> >>>+ * because modified registers in PM functions are different */
> >
> >Coding style, and what does this comment mean ? To me it is just
> >confusing.
> 
> I will move to comment of commit
> 
> >
> >>>+static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
> >>>+{
> >>>+       struct watchdog_device *wdd = dev_get_drvdata(dev);
> >>
> >>drvdata is NULL, too fast,
> >>+       struct watchdog_device *wdd = &stmp3xxx_wdd;
> >>
> >>>+
> >>>+       /* Is keep-on/ping timer suspended before?
> >>>+        * or additional driver-specific flag must be added
> >>>+        *  to block watchdog ping in the timer?
> >>>+        * or disable WATCHDOG_KEEP_ON before wdt_stop
> >>>+        *  and restore it in resume? */
> >
> >You'll have to answer those questions.
> 
> I guess you don't know if timers are stopped before susnder of other
> drivers?
> 
My development methology is on a "need to know" basis. No, I don't know,
since I never needed to. If I am in a situation like this I look at other
drivers and how they solved the problem.

On a side note, I would never assume that there is a race condition unless
I can prove that there is one.

> >
> >>>+       if (watchdog_active(wdd)) {
> >>>+               dev_info(wdd->dev, "%s: wdt was active\n", __func__);
> >
> >Does this message add any value ?
> >
> >>>+               return wdt_stop(wdd);
> >>>+       }
> >>>+       /* should we use pm_runtime like omap_wdt.c does? */
> >
> >Isn't that what you do here ?
> 
> I meant pm_runtime_put/get_sync() etc.
> Maybe it is connected to my question above about timers.
> 
Another need-to-know question.
Best would be to check how other drivers use the functions.

> >
> >>>+
> >>>+       return 0;
> >>>+}
> >>>+
> >>>+static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
> >
> >Does the __maybe_unused really apply ?
> 
> What do you preffer: __maybe_unused or ifdef CONFIG_PM_SLEEP?
> I guess the first one because SIMPLE_DEV_PM_OPS/SET_SYSTEM_SLEEP_PM_OPS
> just uses CONFIG_PM_SLEEP.
> 
None of the above ;-). Keep the __maybe_unused; at least that means
that the code is compiled even if CONFIG_PM_SLEEP is undefined.

Guenter
