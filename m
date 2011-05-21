Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35319 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752807Ab1EUBPC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 May 2011 21:15:02 -0400
Received: by mail-iw0-f180.google.com with SMTP id 6so4245394iwn.25
        for <linux-watchdog@vger.kernel.org>; Fri, 20 May 2011 18:15:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305865276-22410-1-git-send-email-j-keerthy@ti.com>
References: <1305865276-22410-1-git-send-email-j-keerthy@ti.com>
Date: Sat, 21 May 2011 06:45:01 +0530
Message-ID: <BANLkTim4+_OcWn=ykMV285wN9Jh65yPQvA@mail.gmail.com>
Subject: Re: [PATCH] Adding on die temperature check.
From: "J, KEERTHY" <j-keerthy@ti.com>
To: linux-watchdog@vger.kernel.org, s-sabatier1@ti.com, aneesh@ti.com,
	vishwanath.bs@ti.com
Cc: j-keerthy@ti.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

I am sorry for spamming the inbox!

On Fri, May 20, 2011 at 9:51 AM, Keerthy <j-keerthy@ti.com> wrote:
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> =A0arch/arm/cpu/armv7/omap4/board.c =A0 =A0 =A0 =A0 | =A0 56 ++++++++++=
++++++++++++++++++++
> =A0arch/arm/cpu/armv7/omap4/clocks.c =A0 =A0 =A0 =A0| =A0 =A03 ++
> =A0arch/arm/include/asm/arch-omap4/clocks.h | =A0 =A03 ++
> =A0arch/arm/include/asm/arch-omap4/omap4.h =A0| =A0 32 ++++++++++++++++=
+
> =A04 files changed, 94 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/cpu/armv7/omap4/board.c b/arch/arm/cpu/armv7/omap=
4/board.c
> index 5d748cf..cdb9bc1 100644
> --- a/arch/arm/cpu/armv7/omap4/board.c
> +++ b/arch/arm/cpu/armv7/omap4/board.c
> @@ -36,6 +36,7 @@
> =A0#include <asm/utils.h>
> =A0#include <asm/omap_gpio.h>
> =A0#include "omap4_mux_data.h"
> +#include <asm/arch/clocks.h>
>
> =A0DECLARE_GLOBAL_DATA_PTR;
>
> @@ -109,6 +110,60 @@ void wait_for_command_complete(struct watchdog *wd=
_base)
> =A0}
>
> =A0/*
> + * On die temperature sensor check
> + * If the current temperature value is
> + * greater than T_SHUT_HOT apply warm reset
> + */
> +
> +void temp_sensor_check(void)
> +{
> + =A0 =A0 =A0 u32 temp;
> + =A0 =A0 =A0 switch (omap4_hw_init_context()) {
> + =A0 =A0 =A0 case OMAP_INIT_CONTEXT_SPL:
> + =A0 =A0 =A0 case OMAP_INIT_CONTEXT_XIP_UBOOT:
> + =A0 =A0 =A0 case OMAP_INIT_CONTEXT_UBOOT_LOADED_BY_CH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 modify_reg_32(CORE_BANDGAP_COUNTER, BGAP_=
COUNTER_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BGAP_COUNTER_MASK, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable continuous mode. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 modify_reg_32(CORE_BANDGAP_CTRL, BGAP_SIN=
GLE_MODE_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BGAP_SINGLE_MODE_MASK, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait for the conversion to complete. M=
onitor EOCZ */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(readl(CORE_TEMP_SENSOR) & 0x100)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdelay(100);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read the temperature adc_value */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readl(CORE_TEMP_SENSOR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D temp & BGAP_TEMP_SENSOR_DTEMP_MA=
SK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If the samples are untrimmed divide by=
 1.2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (readl(STD_FUSE_OPP_BGAP) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D temp * 5 / 6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Compare with TSHUT high temperature.=
 If high ask the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* user to shut down and restart after =
sometime else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Disable continuous mode.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp < TSHUT_HIGH_ADC_CODE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readl(CORE_BANDG=
AP_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D temp & ~(BGAP_SI=
NGLE_MODE_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writel(temp, CORE_BANDGAP=
_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Device temperatur=
e too high!!!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Please turn off t=
ry booting after sometime\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_MPU);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_CORE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_IVA);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_PER);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_ABE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bypass_dpll(CM_CLKMODE_DP=
LL_USB);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> +}
> +
> +/*
> =A0* Routine: watchdog_init
> =A0* Description: Shut down watch dogs
> =A0*/
> @@ -299,5 +354,6 @@ void s_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readl(CONTROL_ID_CODE), cortex_a9_rev())=
;
> =A0#endif
> =A0 =A0 =A0 =A0prcm_init();
> + =A0 =A0 =A0 temp_sensor_check();
> =A0 =A0 =A0 =A0sdram_init();
> =A0}
> diff --git a/arch/arm/cpu/armv7/omap4/clocks.c b/arch/arm/cpu/armv7/oma=
p4/clocks.c
> index 8c52f21..20e8381 100644
> --- a/arch/arm/cpu/armv7/omap4/clocks.c
> +++ b/arch/arm/cpu/armv7/omap4/clocks.c
> @@ -754,6 +754,9 @@ static void enable_clocks(const u32 *clock_domains,
> =A0*/
> =A0static void enable_basic_clocks(void)
> =A0{
> + =A0 =A0 =A0 /* Enable fucntional clock of on die temperature sensor *=
/
> + =A0 =A0 =A0 writel(readl(CM_WKUP_BANDGAP_CLKCTRL) | OPTFCLKEN_TS_FCLK=
_MASK,
> + =A0 =A0 =A0 CM_WKUP_BANDGAP_CLKCTRL);
> =A0 =A0 =A0 =A0/* Enable optional additional functional clock for GPIO4=
 */
> =A0 =A0 =A0 =A0writel(readl(CM_L4PER_GPIO4_CLKCTRL) | GPIO4_CLKCTRL_OPT=
FCLKEN_MASK,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CM_L4PER_GPIO4_CLKCTRL);
> diff --git a/arch/arm/include/asm/arch-omap4/clocks.h b/arch/arm/includ=
e/asm/arch-omap4/clocks.h
> index e25a6ea..8f9d9ea 100644
> --- a/arch/arm/include/asm/arch-omap4/clocks.h
> +++ b/arch/arm/include/asm/arch-omap4/clocks.h
> @@ -397,6 +397,9 @@
> =A0#define MODULE_CLKCTRL_IDLEST_IDLE =A0 =A0 =A0 =A0 =A0 =A0 2
> =A0#define MODULE_CLKCTRL_IDLEST_DISABLED =A0 =A0 =A0 =A0 3
>
> +/* CM_WKUP_BANDGAP_CLKCTRL */
> +#define OPTFCLKEN_TS_FCLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 8=
)
> +
> =A0/* CM_L4PER_GPIO4_CLKCTRL */
> =A0#define GPIO4_CLKCTRL_OPTFCLKEN_MASK =A0 =A0 =A0 =A0 =A0 (1 << 8)
>
> diff --git a/arch/arm/include/asm/arch-omap4/omap4.h b/arch/arm/include=
/asm/arch-omap4/omap4.h
> index d68a2cf..015e6e3 100644
> --- a/arch/arm/include/asm/arch-omap4/omap4.h
> +++ b/arch/arm/include/asm/arch-omap4/omap4.h
> @@ -99,6 +99,38 @@
> =A0/* GPMC */
> =A0#define OMAP44XX_GPMC_BASE =A0 =A0 0x50000000
>
> +/* OMAP4460 on die TEMPERATURE SENSOR */
> +#define CORE_BANDGAP_COUNTER =A0 (OMAP44XX_L4_CORE_BASE + 0x237C)
> +#define CORE_BANDGAP_CTRL =A0 =A0 =A0(OMAP44XX_L4_CORE_BASE + 0x2378)
> +#define CORE_TEMP_SENSOR =A0 =A0 =A0 (OMAP44XX_L4_CORE_BASE + 0x232C)
> +#define STD_FUSE_OPP_BGAP =A0 =A0 =A0(OMAP44XX_L4_CORE_BASE + 0x2260)
> +
> +/* BANDGAP_COUNTER */
> +#define BGAP_COUNTER_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define BGAP_COUNTER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xffffff << 0)
> +
> +/* BANDGAP_CTRL */
> +#define BGAP_SINGLE_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 31
> +#define BGAP_SINGLE_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 <<=
 31)
> +#define OMAP4_MASK_HOT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
> +#define OMAP4_MASK_HOT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 =
<< 1)
> +#define OMAP4_MASK_COLD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +#define OMAP4_MASK_COLD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 <<=
 0)
> +
> +/* TEMP_SENSOR */
> +#define BGAP_TEMPSOFF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A013
> +#define BGAP_TEMPSOFF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 =
<< 13)
> +#define BGAP_TEMP_SENSOR_CONTCONV_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
12
> +#define BGAP_TEMP_SENSOR_CONTCONV_MASK =A0 =A0 =A0 =A0 (1 << 12)
> +#define BGAP_TEMP_SENSOR_SOC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 11
> +#define BGAP_TEMP_SENSOR_SOC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 11)
> +#define BGAP_TEMP_SENSOR_EOCZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A010
> +#define BGAP_TEMP_SENSOR_EOCZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 (1 << 10)
> +#define BGAP_TEMP_SENSOR_DTEMP_SHIFT =A0 =A0 =A0 =A0 =A0 0
> +#define BGAP_TEMP_SENSOR_DTEMP_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x3ff << 0=
)
> +
> +/* TSHUT high ADC code */
> +#define TSHUT_HIGH_ADC_CODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0923
>
> =A0/*
> =A0* Hardware Register Details
> --
> 1.7.0.4
>
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
