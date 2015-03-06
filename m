Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35417 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbCFIgG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Mar 2015 03:36:06 -0500
Received: by wibbs8 with SMTP id bs8so1765863wib.0
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Mar 2015 00:36:03 -0800 (PST)
Message-ID: <54F966F1.4090900@linaro.org>
Date: Fri, 06 Mar 2015 09:36:01 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/9] ARM: at91: time: move the system timer driver
 to drivers/clocksource
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com> <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
> Import at91rm9200_time.c from mach-at91 as timer-atmel-st.c. Further =
cleanup is
> required to get rid of the mach-at91 headers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   arch/arm/mach-at91/Makefile                                        =
   | 2 +-
>   drivers/clocksource/Kconfig                                        =
   | 4 ++++
>   drivers/clocksource/Makefile                                       =
   | 1 +
>   .../at91rm9200_time.c =3D> drivers/clocksource/timer-atmel-st.c    =
     | 0
>   4 files changed, 6 insertions(+), 1 deletion(-)
>   rename arch/arm/mach-at91/at91rm9200_time.c =3D> drivers/clocksourc=
e/timer-atmel-st.c (100%)
>
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefil=
e
> index 827fdbcce1c7..963c29169242 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -7,7 +7,7 @@ obj-y		:=3D setup.o
>   obj-$(CONFIG_SOC_AT91SAM9)	+=3D sam9_smc.o
>
>   # CPU-specific support
> -obj-$(CONFIG_SOC_AT91RM9200)	+=3D at91rm9200.o at91rm9200_time.o
> +obj-$(CONFIG_SOC_AT91RM9200)	+=3D at91rm9200.o
>   obj-$(CONFIG_SOC_AT91SAM9)	+=3D at91sam9.o
>   obj-$(CONFIG_SOC_SAMA5)		+=3D sama5.o
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> index 1c2506f68122..d1d15985a4ec 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -138,6 +138,10 @@ config ATMEL_PIT
>   	select CLKSRC_OF if OF
>   	def_bool SOC_AT91SAM9 || SOC_SAMA5
>
> +config ATMEL_ST
> +	select CLKSRC_OF if OF
> +	def_bool SOC_AT91RM9200
> +

H Alexandre,

the global policy is to enable the timer from the platform Kconfig.

So it should be:

config ATMEL_ST
	bool
	select CLKSRC_OF if OF

and change the mach's Kconfig to select this driver for the=20
corresponding platform.

>   config CLKSRC_METAG_GENERIC
>   	def_bool y if METAG
>   	help
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> index 752d5c70b0ef..5b85f6adb258 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -1,5 +1,6 @@
>   obj-$(CONFIG_CLKSRC_OF)	+=3D clksrc-of.o
>   obj-$(CONFIG_ATMEL_PIT)		+=3D timer-atmel-pit.o
> +obj-$(CONFIG_ATMEL_ST)		+=3D timer-atmel-st.o
>   obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+=3D tcb_clksrc.o
>   obj-$(CONFIG_X86_PM_TIMER)	+=3D acpi_pm.o
>   obj-$(CONFIG_SCx200HR_TIMER)	+=3D scx200_hrt.o
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/drivers/clocksour=
ce/timer-atmel-st.c
> similarity index 100%
> rename from arch/arm/mach-at91/at91rm9200_time.c
> rename to drivers/clocksource/timer-atmel-st.c
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
