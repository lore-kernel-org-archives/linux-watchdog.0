Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:43727 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbHRFlo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 01:41:44 -0400
Date: Tue, 18 Aug 2015 08:41:36 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Pratyush Anand <panand@redhat.com>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com
Subject: Re: [PATCH 28/37] watchdog: digicolor: Fix parent of watchdog_device
Message-ID: <20150818054136.GT2765@tarshish>
References: <cover.1439524806.git.panand@redhat.com>
 <d84aa2598fda3d7cc9c3b6092def423b79109ee7.1439524806.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84aa2598fda3d7cc9c3b6092def423b79109ee7.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Pratyush Anand,

On Tue, Aug 18, 2015 at 10:18:01AM +0530, Pratyush Anand wrote:
> Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> is populated.
> 
> cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  drivers/watchdog/digicolor_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
> index 31d8e4936611..50abe1bf62a5 100644
> --- a/drivers/watchdog/digicolor_wdt.c
> +++ b/drivers/watchdog/digicolor_wdt.c
> @@ -143,6 +143,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
>  	}
>  	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
>  	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
> +	dc_wdt_wdd.parent = &pdev->dev;

Is there a reasonable way do this for all drivers (at least by default) in 
generic code?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
