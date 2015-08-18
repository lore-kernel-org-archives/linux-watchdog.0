Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37534 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbHRGsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 02:48:14 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Pratyush Anand <panand@redhat.com>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com
Subject: Re: [PATCH 22/37] watchdog: mena21: Fix parent of watchdog_device
References: <cover.1439524806.git.panand@redhat.com>
	<cover.1439524806.git.panand@redhat.com>
	<a49b0e0f3d04f1e4e55b3694aed8e687010b6110.1439524806.git.panand@redhat.com>
Date: Tue, 18 Aug 2015 08:48:11 +0200
In-Reply-To: <a49b0e0f3d04f1e4e55b3694aed8e687010b6110.1439524806.git.panand@redhat.com>
	(Pratyush Anand's message of "Tue, 18 Aug 2015 10:17:55 +0530")
Message-ID: <mqdbne55bys.fsf@c203.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Pratyush Anand <panand@redhat.com> writes:

> Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> is populated.
>
> cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  drivers/watchdog/mena21_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index d193a5e79c38..69013007dc47 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -197,6 +197,7 @@ static int a21_wdt_probe(struct platform_device *pdev)
>  	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
>  	watchdog_set_nowayout(&a21_wdt, nowayout);
>  	watchdog_set_drvdata(&a21_wdt, drv);
> +	a21_wdt.parent = &pdev->dev;
>  
>  	reset = a21_wdt_get_bootstatus(drv);
>  	if (reset == 2)

Good catch

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                           Storage
jthumshirn@suse.de                                 +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600  D0D0 0393 969D 2D76 0850
