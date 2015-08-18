Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from shell.v3.sk ([92.60.52.57]:49889 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbbHRUca (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 16:32:30 -0400
Message-ID: <1439929504.31420.15.camel@v3.sk>
Subject: Re: [PATCH 37/37] watchdog: bcm2835: Fix parent of watchdog_device
From: Lubomir Rintel <lkundrak@v3.sk>
To: Pratyush Anand <panand@redhat.com>, linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com
Date: Tue, 18 Aug 2015 22:25:04 +0200
In-Reply-To: <0aa282cbbe45870937b056c20461a972bedcf173.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
	 <0aa282cbbe45870937b056c20461a972bedcf173.1439524806.git.panand@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2015-08-18 at 10:18 +0530, Pratyush Anand wrote:
> Fix parent of watchdog_device so that 
> /sys/class/watchdog/watchdogn/device
> is populated.
> 
> cc: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Pratyush Anand <panand@redhat.com>

Thank you!

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  drivers/watchdog/bcm2835_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/bcm2835_wdt.c 
> b/drivers/watchdog/bcm2835_wdt.c
> index 7116968dee12..66c3e656a616 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -182,6 +182,7 @@ static int bcm2835_wdt_probe(struct 
> platform_device *pdev)
>  	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
>  	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
>  	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
> +	bcm2835_wdt_wdd.parent = &pdev->dev;
>  	err = watchdog_register_device(&bcm2835_wdt_wdd);
>  	if (err) {
>  		dev_err(dev, "Failed to register watchdog device");
