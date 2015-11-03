Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:52724 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbKCOVQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 09:21:16 -0500
Date: Tue, 3 Nov 2015 09:21:12 -0500
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [RFC PATCH 02/13] watchdog: bcm47xx_wdt: use core restart handler
Message-ID: <20151103142112.GA26902@ketchup.mtl.sfl>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <56381B3B.70202@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56381B3B.70202@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On Nov. Monday 02 (45) 06:26 PM, Guenter Roeck wrote:
> On 11/02/2015 05:36 PM, Damien Riegel wrote:
> >Get rid of the custom restart handler by using the one provided by the
> >watchdog core.
> >
> >Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> >Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

<snip>

> >@@ -221,23 +222,15 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err_timer;
> >
> >-	wdt->restart_handler.notifier_call = &bcm47xx_wdt_restart;
> >-	wdt->restart_handler.priority = 64;
> >-	ret = register_restart_handler(&wdt->restart_handler);
> >-	if (ret)
> >-		goto err_notifier;
> >-
> >  	ret = watchdog_register_device(&wdt->wdd);
> >  	if (ret)
> >-		goto err_handler;
> >+		goto err_notifier;
> 
> 		goto err_handler;

I think we want err_notifier here, since it is the label which
unregisters the reboot notifier, and err_handler gets removed.

> 
> >
> >  	dev_info(&pdev->dev, "BCM47xx Watchdog Timer enabled (%d seconds%s%s)\n",
> >  		timeout, nowayout ? ", nowayout" : "",
> >  		soft ? ", Software Timer" : "");
> >  	return 0;
> >
> >-err_handler:
> >-	unregister_restart_handler(&wdt->restart_handler);
> >  err_notifier:
> >  	unregister_reboot_notifier(&wdt->notifier);
> >  err_timer:

Thanks,
-v
