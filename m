Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51431 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420AbaHVBcu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Aug 2014 21:32:50 -0400
Message-ID: <53F69DBA.4070806@suse.de>
Date: Fri, 22 Aug 2014 03:32:42 +0200
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Doug Anderson <dianders@chromium.org>
CC: Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Tomasz Figa <t.figa@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/11] arm: Support restart through restart handler
 call chain
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net> <1408495538-27480-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1408495538-27480-5-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Am 20.08.2014 02:45, schrieb Guenter Roeck:
> The kernel core now supports a restart handler call chain for system
> restart functions.
>=20
> With this change, the arm_pm_restart callback is now optional, so
> drop its initialization and check if it is set before calling it.
> Only call the kernel restart handler if arm_pm_restart is not set.
[...]
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 81ef686..ea279f7 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -114,17 +114,13 @@ void soft_restart(unsigned long addr)
>  	BUG();
>  }
> =20
> -static void null_restart(enum reboot_mode reboot_mode, const char *c=
md)
> -{
> -}
> -
>  /*
>   * Function pointers to optional machine specific functions
>   */
>  void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
> =20
> -void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd=
) =3D null_restart;
> +void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd=
);

Stupid newbie question maybe, but isn't this variable uninitialized now=
,
like any non-static variable in C99? Or does the kernel assure that all
such "fields" are zero-initialized?

>  EXPORT_SYMBOL_GPL(arm_pm_restart);

(This doesn't seem to be affecting the value of arm_pm_restart, just
redeclaring it extern and adding further derived symbols.)

> =20
>  /*
> @@ -230,7 +226,10 @@ void machine_restart(char *cmd)
>  	local_irq_disable();
>  	smp_send_stop();
> =20
> -	arm_pm_restart(reboot_mode, cmd);
> +	if (arm_pm_restart)

Here we seem to be relying on arm_pm_restart to be NULL when not
callable. I.e., wondering whether it's ruled out that the following lin=
e
is triggered due to non-zero garbage in arm_pm_restart?

Thanks,
Andreas

> +		arm_pm_restart(reboot_mode, cmd);
> +	else
> +		do_kernel_restart(cmd);
> =20
>  	/* Give a grace period for failure to restart of 1s */
>  	mdelay(1000);

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrn=
berg
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
