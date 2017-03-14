Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37520 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdCNLOy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Mar 2017 07:14:54 -0400
Received: by mail-wm0-f50.google.com with SMTP id n11so60961713wma.0
        for <linux-watchdog@vger.kernel.org>; Tue, 14 Mar 2017 04:14:52 -0700 (PDT)
Date: Tue, 14 Mar 2017 11:14:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mfd: db8500-prcmu: fix stub helper interface
Message-ID: <20170314111449.m4kejht32bdejxfk@dell>
References: <20170228210123.3404816-1-arnd@arndb.de>
 <20170228210123.3404816-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228210123.3404816-3-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2017, Arnd Bergmann wrote:

> When the db8500 watchdog is enabled without the PRCMU, we get a lot of
> warnings about duplicate or missing helper functions:
>=20
> In file included from drivers/watchdog/ux500_wdt.c:21:0:
> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_=
abb_read'
>  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
>=20
> This removes the duplicate function definitions and moves the helpers i=
n
> dbx500-prcmu outside of the #ifdef that hides them.
>=20
> Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/mfd/db8500-prcmu.h | 27 ----------------------
>  include/linux/mfd/dbx500-prcmu.h | 49 ++++++++++++++++++++------------=
--------
>  2 files changed, 25 insertions(+), 51 deletions(-)

Is this patch still valid?

> diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db850=
0-prcmu.h
> index 7ba67b55b312..ac9b8a6b8e9c 100644
> --- a/include/linux/mfd/db8500-prcmu.h
> +++ b/include/linux/mfd/db8500-prcmu.h
> @@ -500,17 +500,12 @@ void prcmu_configure_auto_pm(struct prcmu_auto_pm=
_config *sleep,
>  	struct prcmu_auto_pm_config *idle);
>  bool prcmu_is_auto_pm_enabled(void);
> =20
> -int prcmu_config_clkout(u8 clkout, u8 source, u8 div);
>  int prcmu_set_clock_divider(u8 clock, u8 divider);
>  int db8500_prcmu_config_hotdog(u8 threshold);
>  int db8500_prcmu_config_hotmon(u8 low, u8 high);
>  int db8500_prcmu_start_temp_sense(u16 cycles32k);
>  int db8500_prcmu_stop_temp_sense(void);
> -int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
> -int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
> =20
> -int prcmu_ac_wake_req(void);
> -void prcmu_ac_sleep_req(void);
>  void db8500_prcmu_modem_reset(void);
> =20
>  int db8500_prcmu_config_a9wdog(u8 num, bool sleep_auto_off);
> @@ -608,11 +603,6 @@ static inline bool prcmu_is_auto_pm_enabled(void)
>  	return false;
>  }
> =20
> -static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
> -{
> -	return 0;
> -}
> -
>  static inline int prcmu_set_clock_divider(u8 clock, u8 divider)
>  {
>  	return 0;
> @@ -638,23 +628,6 @@ static inline int db8500_prcmu_stop_temp_sense(voi=
d)
>  	return 0;
>  }
> =20
> -static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
> -{
> -	return -ENOSYS;
> -}
> -
> -static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size=
)
> -{
> -	return -ENOSYS;
> -}
> -
> -static inline int prcmu_ac_wake_req(void)
> -{
> -	return 0;
> -}
> -
> -static inline void prcmu_ac_sleep_req(void) {}
> -
>  static inline void db8500_prcmu_modem_reset(void) {}
> =20
>  static inline void db8500_prcmu_system_reset(u16 reset_code) {}
> diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx50=
0-prcmu.h
> index 2e2c6a63a065..533459c7ad08 100644
> --- a/include/linux/mfd/dbx500-prcmu.h
> +++ b/include/linux/mfd/dbx500-prcmu.h
> @@ -376,30 +376,6 @@ static inline void prcmu_write_masked(unsigned int=
 reg, u32 mask, u32 value)
>  	db8500_prcmu_write_masked(reg, mask, value);
>  }
> =20
> -static inline int prcmu_enable_a9wdog(u8 id)
> -{
> -	return db8500_prcmu_enable_a9wdog(id);
> -}
> -
> -static inline int prcmu_disable_a9wdog(u8 id)
> -{
> -	return db8500_prcmu_disable_a9wdog(id);
> -}
> -
> -static inline int prcmu_kick_a9wdog(u8 id)
> -{
> -	return db8500_prcmu_kick_a9wdog(id);
> -}
> -
> -static inline int prcmu_load_a9wdog(u8 id, u32 timeout)
> -{
> -	return db8500_prcmu_load_a9wdog(id, timeout);
> -}
> -
> -static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
> -{
> -	return db8500_prcmu_config_a9wdog(num, sleep_auto_off);
> -}
>  #else
> =20
>  static inline void prcmu_early_init(u32 phy_base, u32 size) {}
> @@ -569,6 +545,31 @@ static inline void prcmu_write_masked(unsigned int=
 reg, u32 mask, u32 value) {}
> =20
>  #endif
> =20
> +static inline int prcmu_enable_a9wdog(u8 id)
> +{
> +	return db8500_prcmu_enable_a9wdog(id);
> +}
> +
> +static inline int prcmu_disable_a9wdog(u8 id)
> +{
> +	return db8500_prcmu_disable_a9wdog(id);
> +}
> +
> +static inline int prcmu_kick_a9wdog(u8 id)
> +{
> +	return db8500_prcmu_kick_a9wdog(id);
> +}
> +
> +static inline int prcmu_load_a9wdog(u8 id, u32 timeout)
> +{
> +	return db8500_prcmu_load_a9wdog(id, timeout);
> +}
> +
> +static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
> +{
> +	return db8500_prcmu_config_a9wdog(num, sleep_auto_off);
> +}
> +
>  static inline void prcmu_set(unsigned int reg, u32 bits)
>  {
>  	prcmu_write_masked(reg, bits, bits);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
