Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50505 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeGGV01 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 7 Jul 2018 17:26:27 -0400
Date: Sat, 7 Jul 2018 14:26:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: wim@linux-watchdog.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] watchdog: stm32: replace "%p" with "%pK"
Message-ID: <20180707212624.GC1951@roeck-us.net>
References: <20180706130808.22466-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130808.22466-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 06, 2018 at 03:08:08PM +0200, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
The pointer has zero value either way. If the clock has a name,
it might make sense to display it. Otherwise just drop the pointer.

Guenter

> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index c97ad5619cb0..740f74a98644 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -172,7 +172,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare_enable(clk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
> +		dev_err(&pdev->dev, "Unable to prepare clock %pK\n", clk);
>  		return ret;
>  	}
>  
> -- 
> 2.15.0
> 
