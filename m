Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:40782 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbCMKOX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 06:14:23 -0400
Received: by wevk48 with SMTP id k48so22158664wev.7
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2015 03:14:21 -0700 (PDT)
Message-ID: <5502B87B.2030300@linaro.org>
Date: Fri, 13 Mar 2015 11:14:19 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v5 07/10] ARM: at91: time: move the system timer driver
 to drivers/clocksource
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <1426162054-9987-8-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-8-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/12/2015 01:07 PM, Alexandre Belloni wrote:
> Import at91rm9200_time.c from mach-at91 as timer-atmel-st.c. Further =
cleanup is
> required to get rid of the mach-at91 headers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

It would have make more sense to remove the mach headers first and then=
=20
move the code in the clocksource directory, but anyway ... :)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm/mach-at91/Kconfig                                         =
   | 1 +
>   arch/arm/mach-at91/Makefile                                        =
   | 2 +-
>   drivers/clocksource/Kconfig                                        =
   | 4 ++++
>   drivers/clocksource/Makefile                                       =
   | 1 +
>   .../at91rm9200_time.c =3D> drivers/clocksource/timer-atmel-st.c    =
     | 0
>   5 files changed, 7 insertions(+), 1 deletion(-)
>   rename arch/arm/mach-at91/at91rm9200_time.c =3D> drivers/clocksourc=
e/timer-atmel-st.c (100%)
>
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index c74a44324e5b..dabce086fa47 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -77,6 +77,7 @@ if SOC_SAM_V4_V5
>   config SOC_AT91RM9200
>   	bool "AT91RM9200"
>   	select ATMEL_AIC_IRQ
> +	select ATMEL_ST
>   	select COMMON_CLK_AT91
>   	select CPU_ARM920T
>   	select GENERIC_CLOCKEVENTS
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
> index 1c2506f68122..6c45f504baff 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -138,6 +138,10 @@ config ATMEL_PIT
>   	select CLKSRC_OF if OF
>   	def_bool SOC_AT91SAM9 || SOC_SAMA5
>
> +config ATMEL_ST
> +	bool
> +	select CLKSRC_OF
> +
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
