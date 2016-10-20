Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35727 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755976AbcJTQXF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2016 12:23:05 -0400
Received: by mail-pf0-f173.google.com with SMTP id s8so39890764pfj.2
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Oct 2016 09:23:05 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
Date: Thu, 20 Oct 2016 09:23:03 -0700
In-Reply-To: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
        (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 16:49:42
        -0300")
Message-ID: <7hd1iv7zx4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Javier Martinez Canillas <javier@osg.samsung.com> writes:

> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
>
> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
> since the reported uevent MODALIAS to user-space will be the OF one.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
>  drivers/watchdog/meson_gxbb_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 44d180a2c5e5..45d47664a00a 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -264,7 +264,6 @@ static struct platform_driver meson_gxbb_wdt_driver = {
>  
>  module_platform_driver(meson_gxbb_wdt_driver);
>  
> -MODULE_ALIAS("platform:meson-gxbb-wdt");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>  MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
>  MODULE_LICENSE("Dual BSD/GPL");
