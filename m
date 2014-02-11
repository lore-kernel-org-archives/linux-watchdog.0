Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:49884 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaBKHo4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 02:44:56 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so8781682oah.17
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Feb 2014 23:44:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000701cf26f6$03fc9950$0bf5cbf0$%han@samsung.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
	<000701cf26f6$03fc9950$0bf5cbf0$%han@samsung.com>
Date: Tue, 11 Feb 2014 13:14:55 +0530
Message-ID: <CAKohpomfuWHn4tUgiWs8-fj+7P0Y=kGayC7JPJ660kxmMF-WDQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] watchdog: sp805_wdt: Remove unnecessary OOM messages
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11 February 2014 12:23, Jingoo Han <jg1.han@samsung.com> wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/sp805_wdt.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 3f786ce..d7da73e 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -218,7 +218,6 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>
>         wdt = devm_kzalloc(&adev->dev, sizeof(*wdt), GFP_KERNEL);
>         if (!wdt) {
> -               dev_warn(&adev->dev, "Kzalloc failed\n");
>                 ret = -ENOMEM;
>                 goto err;
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
