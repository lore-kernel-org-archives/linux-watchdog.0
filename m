Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36442 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbHRGlL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 02:41:11 -0400
Received: by pawq9 with SMTP id q9so28391154paw.3
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2015 23:41:10 -0700 (PDT)
Date: Tue, 18 Aug 2015 12:11:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com, Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH 11/37] watchdog: sp805: Fix parent of watchdog_device
Message-ID: <20150818064104.GA30470@linux>
References: <cover.1439524806.git.panand@redhat.com>
 <4535d0542876d504b4b390c3b1aca408bc021630.1439524806.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4535d0542876d504b4b390c3b1aca408bc021630.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18-08-15, 10:17, Pratyush Anand wrote:
> Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> is populated.
> 
> cc: Viresh Kumar <vireshk@kernel.org>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  drivers/watchdog/sp805_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 4e7fec36f5c3..01d816251302 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -226,6 +226,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>  	wdt->adev = adev;
>  	wdt->wdd.info = &wdt_info;
>  	wdt->wdd.ops = &wdt_ops;
> +	wdt->wdd.parent = &adev->dev;
>  
>  	spin_lock_init(&wdt->lock);
>  	watchdog_set_nowayout(&wdt->wdd, nowayout);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
