Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38955 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeKFGlO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Nov 2018 01:41:14 -0500
Date: Mon, 5 Nov 2018 13:19:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: wim@linux-watchdog.org, yuenn@google.com, venture@google.com,
        benjaminfair@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: npcm: Modify npcm watchdog kconfig arch
 parameter
Message-ID: <20181105211935.GB15984@roeck-us.net>
References: <20181105161152.205524-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105161152.205524-1-tmaimon77@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 05, 2018 at 06:11:52PM +0200, Tomer Maimon wrote:
> Modify Nuvoton watchdog Kconfig default supported architecture
> name to ARCH_NPCM7XX because ARCH_NPCM750 architecture name
> is not supported.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2d64333f4782..746759ec8960 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -538,7 +538,7 @@ config COH901327_WATCHDOG
>  config NPCM7XX_WATCHDOG
>  	bool "Nuvoton NPCM750 watchdog"
>  	depends on ARCH_NPCM || COMPILE_TEST
> -	default y if ARCH_NPCM750
> +	default y if ARCH_NPCM7XX
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here to include Watchdog timer support for the
> -- 
> 2.14.1
> 
