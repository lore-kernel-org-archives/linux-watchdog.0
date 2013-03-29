Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.vodafone.ie ([213.233.128.43]:57179 "EHLO
	mail1.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3C2Lq2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Mar 2013 07:46:28 -0400
Message-ID: <51557CC7.1090108@draigBrady.com>
Date: Fri, 29 Mar 2013 11:36:39 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Tony Chung <tonychung00@gmail.com>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog:improve w83627hf_wdt to timeout in minutes
References: <1364184957-32386-1-git-send-email-tonychung00@gmail.com>
In-Reply-To: <1364184957-32386-1-git-send-email-tonychung00@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/25/2013 04:15 AM, Tony Chung wrote:
> The current maximum of 255 seconds is insufficient.
> For example, crash dump could take 5+ minutes.
>=20
> Signed-off-by: Tony Chung <tonychung00@gmail.com>
> ---
>  drivers/watchdog/w83627hf_wdt.c |   73 +++++++++++++++++++++++++++++=
+--------
>  1 files changed, 57 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w8362=
7hf_wdt.c
> index 92f1326..d26adfb 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -58,7 +58,7 @@ MODULE_PARM_DESC(wdt_io, "w83627hf/thf WDT io port =
(default 0x2E)");
>  static int timeout =3D WATCHDOG_TIMEOUT;	/* in seconds */
>  module_param(timeout, int, 0);
>  MODULE_PARM_DESC(timeout,
> -		"Watchdog timeout in seconds. 1 <=3D timeout <=3D 255, default=3D"
> +		"Watchdog timeout in seconds. 1 <=3D timeout <=3D 15300, default=3D=
"
>  				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> =20
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> @@ -67,6 +67,29 @@ MODULE_PARM_DESC(nowayout,
>  		"Watchdog cannot be stopped once started (default=3D"
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> =20
> +/* timeout unit in minute */
> +static bool use_minute;
> +static char *unit;
> +static int max_timeout =3D 15300; /* 255*60 seconds */
> +
> +static inline int wdt_round_secs_to_minute(int t)
> +{
> +	return (t + 59) / 60;
> +}
> +
> +static inline int wdt_use_minute(int t)
> +{
> +	if (t > 255) {
> +		t =3D wdt_round_secs_to_minute(t);
> +		use_minute =3D 1;
> +		unit =3D "minutes";
> +	} else {
> +		use_minute =3D 0;
> +		unit =3D "secs";
> +	}
> +	return t;
> +}
> +
>  /*
>   *	Kernel methods.
>   */
> @@ -107,6 +130,23 @@ static void w83627hf_unselect_wd_register(void)
>  	outb_p(0xAA, WDT_EFER); /* Leave extended function mode */
>  }
> =20
> +/* set CRF5 register */
> +static void w83627hf_set_crf5(void)
> +{
> +	unsigned char t;
> +
> +	outb_p(0xF5, WDT_EFER); /* Select CRF5 */
> +	t =3D inb_p(WDT_EFDR);      /* read CRF5 */
> +	t &=3D ~0x0C;               /* set second mode & disable keyboard
> +				    turning off watchdog */
> +	t |=3D 0x02;		  /* enable the WDTO# output low pulse
> +				    to the KBRST# pin (PIN60) */
> +	if (use_minute)
> +		t |=3D 0x80;        /* set timeout in minute */
> +
> +	outb_p(t, WDT_EFDR);    /* Write back to CRF5 */
> +}
> +
>  /* tyan motherboards seem to set F5 to 0x4C ?
>   * So explicitly init to appropriate value. */
> =20
> @@ -116,21 +156,16 @@ static void w83627hf_init(void)
> =20
>  	w83627hf_select_wd_register();
> =20
> +	w83627hf_set_crf5();
> +
>  	outb_p(0xF6, WDT_EFER); /* Select CRF6 */
>  	t =3D inb_p(WDT_EFDR);      /* read CRF6 */
>  	if (t !=3D 0) {
> -		pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> -			timeout);
> +		pr_info("Watchdog already running.  Reset timeout to %d %s\n",
> +			timeout, unit);

"Resetting" is better as otherwise it might read as an instruction to t=
he user.
Alternatively you could have: "Timeout was reset to ..."

>  		outb_p(timeout, WDT_EFDR);    /* Write back to CRF6 */
>  	}
> =20
> -	outb_p(0xF5, WDT_EFER); /* Select CRF5 */
> -	t =3D inb_p(WDT_EFDR);      /* read CRF5 */
> -	t &=3D ~0x0C;               /* set second mode & disable keyboard
> -				    turning off watchdog */
> -	t |=3D 0x02;		  /* enable the WDTO# output low pulse
> -				    to the KBRST# pin (PIN60) */
> -	outb_p(t, WDT_EFDR);    /* Write back to CRF5 */
> =20
>  	outb_p(0xF7, WDT_EFER); /* Select CRF7 */
>  	t =3D inb_p(WDT_EFDR);      /* read CRF7 */
> @@ -147,6 +182,9 @@ static void wdt_set_time(int timeout)
> =20
>  	w83627hf_select_wd_register();
> =20
> +	if (use_minute)
> +		w83627hf_set_crf5();

Why is this bit needed in set_time()?

On a general note, one has to be careful when changing
between second and minute modes, if the watchdog is already running
(from the BIOS for example).

thanks,
P=E1draig.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
