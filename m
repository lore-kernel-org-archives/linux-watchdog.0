Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeILVHm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Sep 2018 17:07:42 -0400
Date: Wed, 12 Sep 2018 09:02:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jagdish Tirumala <t.jag587@gmail.com>
Cc: wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WATCHDOG: uniphier_wdt.c: Fixed error do not initialise
 statics to 0
Message-ID: <20180912160229.GA3300@roeck-us.net>
References: <20180912153354.4658-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912153354.4658-1-t.jag587@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 12, 2018 at 08:33:54AM -0700, Jagdish Tirumala wrote:
> Fixed error do not initialise statics to 0
> in file drivers/watchdog/uniphier_wdt.c
> 

I don't mind the patch, but I do mind both subject and description
as misleading. This is not an error, except for checkpatch.

A subject such as "watchdog: uniphier_wdt: Do not initialize static
variables to 0" and a description along the line of

Fix the following checkpatch error:

ERROR: do not initialise statics to 0
#44: FILE: drivers/watchdog/uniphier_wdt.c:44:
+static unsigned int timeout = 0;

would be more appropriate.

Please also note that the watchdog subsystem does not use capital
letters to describe the subsystem name, and the driver tag should not
include ".c". As a general note, I would suggest to do a quick browse
through commits in a subsystem to get an idea about its conventions.

Thanks,
Guenter

> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
>  drivers/watchdog/uniphier_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index e20a7a459d69..2c62ad7250fb 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -41,7 +41,7 @@
>  #define WDT_PERIOD_MIN			1
>  #define WDT_PERIOD_MAX			128
>  
> -static unsigned int timeout = 0;
> +static unsigned int timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  struct uniphier_wdt_dev {
> -- 
> 2.17.1
> 
