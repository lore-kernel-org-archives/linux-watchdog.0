Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61107 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab2HQLXY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Aug 2012 07:23:24 -0400
Received: by vbbff1 with SMTP id ff1so3109401vbb.19
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Aug 2012 04:23:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344332652-9455-1-git-send-email-sachin.kamat@linaro.org>
References: <1344332652-9455-1-git-send-email-sachin.kamat@linaro.org>
Date: Fri, 17 Aug 2012 16:53:23 +0530
Message-ID: <CAK9yfHzSVxP6RA3i2N7-X+9wh4c38Q7aGZb7SSCvM1i+jn40XA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: da9052: Remove duplicate inclusion of delay.h
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, sachin.kamat@linaro.org, patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ping...

On 7 August 2012 15:14, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> delay.h header file was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/da9052_wdt.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index 3f75129..f7abbae 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -21,7 +21,6 @@
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
> -#include <linux/delay.h>
>
>  #include <linux/mfd/da9052/reg.h>
>  #include <linux/mfd/da9052/da9052.h>
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
