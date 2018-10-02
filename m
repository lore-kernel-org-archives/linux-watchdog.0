Return-Path: <wim@linux-watchdog.org>
Return-path: <wim@linux-watchdog.org>
Date: Tue, 2 Oct 2018 13:35:16 +0200
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: w83627hf_wdt: Support NCT6796D, NCT6797D,
 NCT6798D
Message-ID: <20181002113516.GA8957@www.linux-watchdog.org>
References: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Sep 23, 2018 at 06:54:11AM -0700, Guenter Roeck wrote:

> The watchdog controller on NCT6796D, NCT6797D, and NCT6798D is compatible
> with the wtachdog controller on other Nuvoton chips.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Wim Van Sebroeck <wim@linux-watchdog.org>

> ---
>  drivers/watchdog/w83627hf_wdt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index 7817836bff55..4b9365d4de7a 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -50,7 +50,7 @@ static int cr_wdt_csr;		/* WDT control & status register */
>  enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>  	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
>  	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
> -	     nct6795, nct6102 };
> +	     nct6795, nct6796, nct6102 };
>  
>  static int timeout;			/* in seconds */
>  module_param(timeout, int, 0);
> @@ -100,6 +100,7 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>  #define NCT6792_ID		0xc9
>  #define NCT6793_ID		0xd1
>  #define NCT6795_ID		0xd3
> +#define NCT6796_ID		0xd4	/* also NCT9697D, NCT9698D */
>  
>  #define W83627HF_WDT_TIMEOUT	0xf6
>  #define W83697HF_WDT_TIMEOUT	0xf4
> @@ -209,6 +210,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>  	case nct6792:
>  	case nct6793:
>  	case nct6795:
> +	case nct6796:
>  	case nct6102:
>  		/*
>  		 * These chips have a fixed WDTO# output pin (W83627UHG),
> @@ -407,6 +409,9 @@ static int wdt_find(int addr)
>  	case NCT6795_ID:
>  		ret = nct6795;
>  		break;
> +	case NCT6796_ID:
> +		ret = nct6796;
> +		break;
>  	case NCT6102_ID:
>  		ret = nct6102;
>  		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
> @@ -450,6 +455,7 @@ static int __init wdt_init(void)
>  		"NCT6792",
>  		"NCT6793",
>  		"NCT6795",
> +		"NCT6796",
>  		"NCT6102",
>  	};
>  
> -- 
> 2.7.4
> 
