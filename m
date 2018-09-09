Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
Subject: Re: [PATCH v2 2/3] wdt: lantiq: Convert to watchdog_device
To: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
References: <20180902113233.29113-1-hauke@hauke-m.de>
 <20180902113233.29113-3-hauke@hauke-m.de>
 <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6315a579-3249-e83b-69ea-54ac13b15799@hauke-m.de>
Date: Sun, 9 Sep 2018 23:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DYBkmnUT6QndCQKW1uyHjQulEG6chpopo"
List-ID: <linux-watchdog@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DYBkmnUT6QndCQKW1uyHjQulEG6chpopo
Content-Type: multipart/mixed; boundary="kG6mtJb8BhscPaEh3jP0adgnyr8lD9TPY";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Guenter Roeck <linux@roeck-us.net>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
Message-ID: <6315a579-3249-e83b-69ea-54ac13b15799@hauke-m.de>
Subject: Re: [PATCH v2 2/3] wdt: lantiq: Convert to watchdog_device
References: <20180902113233.29113-1-hauke@hauke-m.de>
 <20180902113233.29113-3-hauke@hauke-m.de>
 <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>
In-Reply-To: <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>

--kG6mtJb8BhscPaEh3jP0adgnyr8lD9TPY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/04/2018 01:43 AM, Guenter Roeck wrote:
> On 09/02/2018 04:32 AM, Hauke Mehrtens wrote:
>> Instead of doing the ioctl handling manually just use register a
>> watchdog_device and let the watchdog framework do the ioctl handling.
>>
>> This also removes the ltq_wdt_bootstatus_set typedef and replaces it
>> with a structure providing the chip specific functions pointer.
>> The watchdog_init_timeout() function is now used and the initial timeo=
ut
>> can be provided in device tree.
>> If the watchdog was already activated it will not be stopped any more,=

>> but the settings from the driver will be used and the watchdog subsyst=
em
>> will take care.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>> =C2=A0 drivers/watchdog/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
>> =C2=A0 drivers/watchdog/lantiq_wdt.c | 277
>> +++++++++++++++++++-----------------------
>> =C2=A0 2 files changed, 126 insertions(+), 152 deletions(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 5ea8909a41f9..5637d8be31e0 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1621,6 +1621,7 @@ config IMGPDC_WDT
>> =C2=A0 config LANTIQ_WDT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Lantiq SoC watchdog"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on LANTIQ
>> +=C2=A0=C2=A0=C2=A0 select WATCHDOG_CORE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hardware driver for the Lan=
tiq SoC Watchdog Timer.
>> =C2=A0 diff --git a/drivers/watchdog/lantiq_wdt.c
>> b/drivers/watchdog/lantiq_wdt.c
>> index e5937be09bd4..666db382b824 100644
>> --- a/drivers/watchdog/lantiq_wdt.c
>> +++ b/drivers/watchdog/lantiq_wdt.c
>> @@ -8,11 +8,7 @@
>> =C2=A0=C2=A0 *=C2=A0 Based on EP93xx wdt driver
>> =C2=A0=C2=A0 */
>> =C2=A0 -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> -
>> =C2=A0 #include <linux/module.h>
>> -#include <linux/fs.h>
>> -#include <linux/miscdevice.h>
>> =C2=A0 #include <linux/bitops.h>
>> =C2=A0 #include <linux/watchdog.h>
>> =C2=A0 #include <linux/of_platform.h>
>> @@ -55,154 +51,99 @@
>> =C2=A0 =C2=A0 static bool nowayout =3D WATCHDOG_NOWAYOUT;
>> =C2=A0 -static void __iomem *ltq_wdt_membase;
>> -static unsigned long ltq_io_region_clk_rate;
>> +struct ltq_wdt_hw {
>> +=C2=A0=C2=A0=C2=A0 int (*bootstatus_get)(struct device *dev);
>> +};
>> =C2=A0 -static unsigned long ltq_wdt_bootstatus;
>> -static unsigned long ltq_wdt_in_use;
>> -static int ltq_wdt_timeout =3D 30;
>> -static int ltq_wdt_ok_to_close;
>> +struct ltq_wdt_priv {
>> +=C2=A0=C2=A0=C2=A0 struct watchdog_device wdt;
>> +=C2=A0=C2=A0=C2=A0 void __iomem *membase;
>> +=C2=A0=C2=A0=C2=A0 unsigned long clk_rate;
>> +};
>> =C2=A0 -static void
>> -ltq_wdt_enable(void)
>> +static u32 ltq_wdt_r32(struct ltq_wdt_priv *priv, u32 offset)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 unsigned long int timeout =3D ltq_wdt_timeout *
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (l=
tq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
>> -=C2=A0=C2=A0=C2=A0 if (timeout > LTQ_WDT_CR_RELOAD_MASK)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timeout =3D LTQ_WDT_CR_REL=
OAD_MASK;
>> -
>> -=C2=A0=C2=A0=C2=A0 /* write the first password magic */
>> -=C2=A0=C2=A0=C2=A0 ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_=
CR);
>> -=C2=A0=C2=A0=C2=A0 /* write the second magic plus the configuration a=
nd new timeout */
>> -=C2=A0=C2=A0=C2=A0 ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_=
CR_CLKDIV |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTQ_WDT_CR_PW2 | timeout, =
ltq_wdt_membase + LTQ_WDT_CR);
>> +=C2=A0=C2=A0=C2=A0 return __raw_readl(priv->membase + offset);
>> =C2=A0 }
>> =C2=A0 -static void
>> -ltq_wdt_disable(void)
>> +static void ltq_wdt_w32(struct ltq_wdt_priv *priv, u32 val, u32 offse=
t)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 /* write the first password magic */
>> -=C2=A0=C2=A0=C2=A0 ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_=
CR);
>> -=C2=A0=C2=A0=C2=A0 /*
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * write the second password magic with no co=
nfig
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * this turns the watchdog off
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_=
CR);
>> +=C2=A0=C2=A0=C2=A0 return __raw_writel(val, priv->membase + offset);
>> =C2=A0 }
>> =C2=A0 -static ssize_t
>> -ltq_wdt_write(struct file *file, const char __user *data,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len, loff_t *ppos)
>> +static void ltq_wdt_mask(struct ltq_wdt_priv *priv, u32 clear, u32 se=
t,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 offset)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (len) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nowayout) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_t i;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lt=
q_wdt_ok_to_close =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
r (i =3D 0; i !=3D len; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char c;
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (get_user(c, data + i))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (c =3D=3D 'V')
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_ok_to_close =3D 1;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_ok_to_close =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_enable();
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 u32 val =3D ltq_wdt_r32(priv, offset);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return len;
>> +=C2=A0=C2=A0=C2=A0 val &=3D ~(clear);
>> +=C2=A0=C2=A0=C2=A0 val |=3D set;
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_w32(priv, val, offset);
>> =C2=A0 }
>> =C2=A0 -static struct watchdog_info ident =3D {
>> +static struct ltq_wdt_priv *ltq_wdt_get_priv(struct watchdog_device
>> *wdt)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return container_of(wdt, struct ltq_wdt_priv, wdt)=
;
>> +}
>> +
>> +static struct watchdog_info ltq_wdt_info =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .options =3D WDIOF_MAGICCLOSE | WDIOF_S=
ETTIMEOUT |
>> WDIOF_KEEPALIVEPING |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WD=
IOF_CARDRESET,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WDIOF_CA=
RDRESET,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .identity =3D "ltq_wdt",
>> =C2=A0 };
>> =C2=A0 -static long
>> -ltq_wdt_ioctl(struct file *file,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cmd, unsigned=
 long arg)
>> +static int ltq_wdt_start(struct watchdog_device *wdt)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 int ret =3D -ENOTTY;
>> -
>> -=C2=A0=C2=A0=C2=A0 switch (cmd) {
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_GETSUPPORT:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D copy_to_user((stru=
ct watchdog_info __user *)arg, &ident,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sizeof(ident)) ? -EFAULT : 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_GETBOOTSTATUS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D put_user(ltq_wdt_b=
ootstatus, (int __user *)arg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_GETSTATUS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D put_user(0, (int _=
_user *)arg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_SETTIMEOUT:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_user(ltq_wdt_t=
imeout, (int __user *)arg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lt=
q_wdt_enable();
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* intentional drop throug=
h */
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_GETTIMEOUT:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D put_user(ltq_wdt_t=
imeout, (int __user *)arg);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -
>> -=C2=A0=C2=A0=C2=A0 case WDIOC_KEEPALIVE:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_enable();
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 struct ltq_wdt_priv *priv =3D ltq_wdt_get_priv(wdt=
);
>> +=C2=A0=C2=A0=C2=A0 u32 timeout;
>> +
>> +=C2=A0=C2=A0=C2=A0 timeout =3D wdt->timeout * priv->clk_rate;
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_=
PW1, LTQ_WDT_CR);
>> +=C2=A0=C2=A0=C2=A0 /* write the second magic plus the configuration a=
nd new timeout */
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK | LTQ_WDT_CR=
_RELOAD_MASK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 LTQ_WDT_CR_PW2 | timeout,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 LTQ_WDT_CR);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static int
>> -ltq_wdt_open(struct inode *inode, struct file *file)
>> +static int ltq_wdt_stop(struct watchdog_device *wdt)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (test_and_set_bit(0, &ltq_wdt_in_use))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>> -=C2=A0=C2=A0=C2=A0 ltq_wdt_in_use =3D 1;
>> -=C2=A0=C2=A0=C2=A0 ltq_wdt_enable();
>> +=C2=A0=C2=A0=C2=A0 struct ltq_wdt_priv *priv =3D ltq_wdt_get_priv(wdt=
);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return nonseekable_open(inode, file);
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_=
PW1, LTQ_WDT_CR);
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_GEN | LTQ_WDT_CR_PW_=
MASK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 LTQ_WDT_CR_PW2, LTQ_WDT_CR);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static int
>> -ltq_wdt_release(struct inode *inode, struct file *file)
>> +static int ltq_wdt_ping(struct watchdog_device *wdt)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (ltq_wdt_ok_to_close)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_disable();
>> -=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("watchdog closed wi=
thout warning\n");
>> -=C2=A0=C2=A0=C2=A0 ltq_wdt_ok_to_close =3D 0;
>> -=C2=A0=C2=A0=C2=A0 clear_bit(0, &ltq_wdt_in_use);
>> +=C2=A0=C2=A0=C2=A0 struct ltq_wdt_priv *priv =3D ltq_wdt_get_priv(wdt=
);
>> +=C2=A0=C2=A0=C2=A0 u32 timeout;
>> +
>> +=C2=A0=C2=A0=C2=A0 timeout =3D wdt->timeout * priv->clk_rate;
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK, LTQ_WDT_CR_=
PW1, LTQ_WDT_CR);
>> +=C2=A0=C2=A0=C2=A0 /* write the second magic plus the configuration a=
nd new timeout */
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_mask(priv, LTQ_WDT_CR_PW_MASK | LTQ_WDT_CR=
_RELOAD_MASK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 LTQ_WDT_CR_PW2 | timeout, LTQ_WDT_CR);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static const struct file_operations ltq_wdt_fops =3D {
>> +static const struct watchdog_ops ltq_wdt_ops =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .owner=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D THIS_MODULE,
>> -=C2=A0=C2=A0=C2=A0 .write=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 ltq_wdt_write,
>> -=C2=A0=C2=A0=C2=A0 .unlocked_ioctl=C2=A0=C2=A0=C2=A0 =3D ltq_wdt_ioct=
l,
>> -=C2=A0=C2=A0=C2=A0 .open=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 ltq_wdt_open,
>> -=C2=A0=C2=A0=C2=A0 .release=C2=A0=C2=A0=C2=A0 =3D ltq_wdt_release,
>> -=C2=A0=C2=A0=C2=A0 .llseek=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D no_llseek,
>> +=C2=A0=C2=A0=C2=A0 .start=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 ltq_wdt_start,
>> +=C2=A0=C2=A0=C2=A0 .stop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 ltq_wdt_stop,
>> +=C2=A0=C2=A0=C2=A0 .ping=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 ltq_wdt_ping,
>> =C2=A0 };
>> =C2=A0 -static struct miscdevice ltq_wdt_miscdev =3D {
>> -=C2=A0=C2=A0=C2=A0 .minor=C2=A0=C2=A0=C2=A0 =3D WATCHDOG_MINOR,
>> -=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =3D "watchdog",
>> -=C2=A0=C2=A0=C2=A0 .fops=C2=A0=C2=A0=C2=A0 =3D &ltq_wdt_fops,
>> -};
>> -
>> -typedef int (*ltq_wdt_bootstatus_set)(struct platform_device *pdev);
>> -
>> -static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
>> +static int ltq_wdt_bootstatus_xrx(struct device *dev)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *rcu_regmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>> @@ -216,14 +157,13 @@ static int ltq_wdt_bootstatus_xrx(struct
>> platform_device *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val & LTQ_XRX_RCU_RST_STAT_W=
DT)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_bootstatus =3D WDI=
OF_CARDRESET;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return WDIOF_CARDRESET;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static int ltq_wdt_bootstatus_falcon(struct platform_device *p=
dev)
>> +static int ltq_wdt_bootstatus_falcon(struct device *dev)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *rcu_regmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>> @@ -238,62 +178,95 @@ static int ltq_wdt_bootstatus_falcon(struct
>> platform_device *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((val & LTQ_FALCON_SYS1_CPU0R=
S_MASK) =3D=3D
>> LTQ_FALCON_SYS1_CPU0RS_WDT)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_bootstatus =3D WDI=
OF_CARDRESET;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return WDIOF_CARDRESET;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static int
>> -ltq_wdt_probe(struct platform_device *pdev)
>> +static int ltq_wdt_probe(struct platform_device *pdev)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct resource *res =3D platform_get_resource(pde=
v,
>> IORESOURCE_MEM, 0);
>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
>> +=C2=A0=C2=A0=C2=A0 struct ltq_wdt_priv *priv;
>> +=C2=A0=C2=A0=C2=A0 struct watchdog_device *wdt;
>> +=C2=A0=C2=A0=C2=A0 struct resource *res;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk *clk;
>> -=C2=A0=C2=A0=C2=A0 ltq_wdt_bootstatus_set ltq_wdt_bootstatus_set;
>> +=C2=A0=C2=A0=C2=A0 const struct ltq_wdt_hw *ltq_wdt_hw;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 u32 status;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ltq_wdt_membase =3D devm_ioremap_resource(&=
pdev->dev, res);
>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(ltq_wdt_membase))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(ltq_wdt_mem=
base);
>> +=C2=A0=C2=A0=C2=A0 priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERN=
EL);
>> +=C2=A0=C2=A0=C2=A0 if (!priv)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ltq_wdt_bootstatus_set =3D of_device_get_ma=
tch_data(&pdev->dev);
>> -=C2=A0=C2=A0=C2=A0 if (ltq_wdt_bootstatus_set) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ltq_wdt_bootstatus=
_set(pdev);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM=
, 0);
>> +=C2=A0=C2=A0=C2=A0 priv->membase =3D devm_ioremap_resource(dev, res);=

>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(priv->membase))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(priv->memba=
se);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we do not need to enable the =
clock as it is always running */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk =3D clk_get_io();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk)) {
>=20
> Not new, nor that it really matters, but this error check is quite
> pointless:
> The function never returns an error.

Ok, I will remove this.

>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "Faile=
d to get clock\n");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to ge=
t clock");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(clk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 ltq_io_region_clk_rate =3D clk_get_rate(clk);
>> +=C2=A0=C2=A0=C2=A0 priv->clk_rate =3D clk_get_rate(clk) / LTQ_WDT_DIV=
IDER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_put(clk);
>=20
> Calling clk_put() here actually odd and should be dropped. Unlike
> clk_get(),
> clk_get_io() does not get a reference to the clock instance. It just
> returns
> a pointer to a static clock.

I will remove it.

>> +=C2=A0=C2=A0=C2=A0 if (!priv->clk_rate) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "clock has wr=
ong value of 0");
>=20
> This is misleading: It is not known if the clock rate is indeed 0.
> It is only known that the clock rate is below LTQ_WDT_DIVIDER.

Ok I will update this.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>=20
> I am not happy with EIO in this case. There is no indication
> of an I/O error.

Is -EINVAL better?

>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 dev_info(&pdev->dev, "Init done\n");
>> -=C2=A0=C2=A0=C2=A0 return misc_register(&ltq_wdt_miscdev);
>> -}
>> +=C2=A0=C2=A0=C2=A0 wdt =3D &priv->wdt;
>> +=C2=A0=C2=A0=C2=A0 wdt->info=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D &ltq_wdt_info;
>> +=C2=A0=C2=A0=C2=A0 wdt->ops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D &ltq_wdt_ops;
>> +=C2=A0=C2=A0=C2=A0 wdt->min_timeout=C2=A0=C2=A0=C2=A0 =3D 1;
>> +=C2=A0=C2=A0=C2=A0 wdt->max_timeout=C2=A0=C2=A0=C2=A0 =3D LTQ_WDT_CR_=
RELOAD_MASK / priv->clk_rate;
>> +=C2=A0=C2=A0=C2=A0 wdt->timeout=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D wdt->max_timeout;
>> +=C2=A0=C2=A0=C2=A0 wdt->parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D dev;
>> +
>> +=C2=A0=C2=A0=C2=A0 ltq_wdt_hw =3D of_device_get_match_data(dev);
>> +=C2=A0=C2=A0=C2=A0 if (ltq_wdt_hw && ltq_wdt_hw->bootstatus_get) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ltq_wdt_hw->bootst=
atus_get(dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>=20
> This is also quite pointless: The functions never return an error.
> Might as well just assign the returned value to bootstatus.
>=20
> While it makes some sense to have the error checks above (after all,
> the API could change), this one really does not make sense since it is
> in full driver control.

Ok, I will remove this.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wdt->bootstatus =3D ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -static int
>> -ltq_wdt_remove(struct platform_device *pdev)
>> -{
>> -=C2=A0=C2=A0=C2=A0 misc_deregister(&ltq_wdt_miscdev);
>> +=C2=A0=C2=A0=C2=A0 watchdog_set_nowayout(wdt, nowayout);
>> +=C2=A0=C2=A0=C2=A0 watchdog_init_timeout(wdt, 0, dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 status =3D ltq_wdt_r32(priv, LTQ_WDT_CR);
>> +=C2=A0=C2=A0=C2=A0 if (status & LTQ_WDT_CR_GEN) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the watchdog is=
 already running overwrite it with our
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * new settings. Stop=
 is not needed as the start call will
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * replace all settin=
gs anyway.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltq_wdt_start(wdt);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(WDOG_HW_RUNNING, &=
wdt->status);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 return devm_watchdog_register_device(dev, wdt);
>> =C2=A0 }
>> =C2=A0 +static const struct ltq_wdt_hw ltq_wdt_xrx100 =3D {
>> +=C2=A0=C2=A0=C2=A0 .bootstatus_get =3D ltq_wdt_bootstatus_xrx,
>> +};
>> +
>> +static const struct ltq_wdt_hw ltq_wdt_falcon =3D {
>> +=C2=A0=C2=A0=C2=A0 .bootstatus_get =3D ltq_wdt_bootstatus_falcon,
>> +};
>> +
>> =C2=A0 static const struct of_device_id ltq_wdt_match[] =3D {
>> -=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,wdt", .data =3D NULL},
>> -=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,xrx100-wdt", .data =3D
>> ltq_wdt_bootstatus_xrx },
>> -=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,falcon-wdt", .data =3D
>> ltq_wdt_bootstatus_falcon },
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,wdt", .data =3D NULL },
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,xrx100-wdt", .data =3D &=
ltq_wdt_xrx100 },
>> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "lantiq,falcon-wdt", .data =3D &=
ltq_wdt_falcon },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
>> =C2=A0 };
>> =C2=A0 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
>> =C2=A0 =C2=A0 static struct platform_driver ltq_wdt_driver =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D ltq_wdt_probe,
>> -=C2=A0=C2=A0=C2=A0 .remove =3D ltq_wdt_remove,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "wdt"=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .of_match_table=
 =3D ltq_wdt_match,
>>
>=20



--kG6mtJb8BhscPaEh3jP0adgnyr8lD9TPY--

--DYBkmnUT6QndCQKW1uyHjQulEG6chpopo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluVi68ACgkQ8bdnhZyy
68eI9Qf/VzEXToLU0659meOqIs9cA6EQIGRv2jwKHkkXxQKef7g4DG5Q00rilecd
m7KGfHGovoxxI5Ux+f2DBVn5Qs2vqYiAqPqRzO41XW9PCnTId/qvtd/XmHu2dy+9
1ZlB/TYyjH+LoJhrFdqLI56qLxxh9Z2c9EbzfPUYWiV/U92WrsIbUvXU8wH12D1C
xoyt4z1xFIQI8MAGI/1WzRJZ+774MR8zTw9hgE+OZ9OIflSI/tM65byJbwDuehMX
OPyGql0q9ohWxWTx1yQ73EnU2wMOkGiQAPZ8M68oAEXy2AAaU3FfKBY1Kb5MXA/u
LNCxlTvAyTI/S2t5ct/rakuqSXmYLQ==
=UDcA
-----END PGP SIGNATURE-----

--DYBkmnUT6QndCQKW1uyHjQulEG6chpopo--
