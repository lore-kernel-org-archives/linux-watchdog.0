Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34811 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbHRGii (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 02:38:38 -0400
Received: by wicne3 with SMTP id ne3so91639689wic.1
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2015 23:38:36 -0700 (PDT)
Date: Tue, 18 Aug 2015 07:38:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com,
	dzickus@redhat.com, David Paris <david.paris@st.com>,
	kernel@stlinux.com
Subject: Re: [PATCH 10/37] watchdog: st_lpc: Fix parent of watchdog_device
Message-ID: <20150818063834.GB6180@x1>
References: <cover.1439524806.git.panand@redhat.com>
 <4d95204cc2d56673a9dcddf96ee6d6701fe92ecd.1439524806.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d95204cc2d56673a9dcddf96ee6d6701fe92ecd.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 18 Aug 2015, Pratyush Anand wrote:

> Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
> is populated.
> 
> cc: David Paris <david.paris@st.com>
> cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  drivers/watchdog/st_lpc_wdt.c | 1 +
>  1 file changed, 1 insertion(+)

[Cc'ing the ST list, so they can have their say]

Looks reasonable.  At least, it's what most of the other drivers do.

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index 6785afdc0fca..14e9badf2bfa 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -241,6 +241,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  	st_wdog_dev.max_timeout = 0xFFFFFFFF / st_wdog->clkrate;
> +	st_wdog_dev.parent = &pdev->dev;
>  
>  	ret = clk_prepare_enable(clk);
>  	if (ret) {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
