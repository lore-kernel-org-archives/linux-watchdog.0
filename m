Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: add module parameter "force_no_reboot" for
 iTCO
Date: Thu, 5 Jul 2018 06:28:26 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
In-Reply-To: <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi, Roeck

Yes, this patch is for add a parameter to TCO to prevent reboot happen if y=
ou don't want to reboot system=20
and want to stay here to check some HW status, logs, etc for debug purpose.

Under some android related stability test, developer want to stay at the cr=
ash and use debug tools(LTB)
to check more information, this is the purpose of this patch.

Thanks
Tim

-----Original Message-----
From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
Sent: Monday, July 2, 2018 9:21 PM
To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-w=
atchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for i=
TCO

On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for=20
> iTCO
>=20
> Setting "force_no_reboot" parameter to true (y/Y/1) will have the=20
> effect to prevent to reset the NO_REBOOT flag thus preventing the iTCO=20
> to reboot the platform, if not set or set to false, then system will=20
> reboot after about 30s.
>=20
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>

Your e-mail address is messed up.

> ---
>  =A0drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
>  =A01 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c=20
> index 347f038..255318b 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int,=20
> 0);
>  =A0MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>  =A0=A0=A0=A0=A0 "Turn off SMI clearing watchdog (depends on=20
> TCO-version)(default=3D1)");
>=20
> +static bool force_no_reboot;
> +module_param(force_no_reboot, bool, 0);=20
> +MODULE_PARM_DESC(force_no_reboot,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Prevents the watchdog rebooting the plat=
form=20
> +(default=3D0)");
> +
>  =A0/*
>  =A0 * Some TCO specific functions
>  =A0 */
> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device=20
> *wd_dev)
>  =A0=A0=A0=A0=A0 struct iTCO_wdt_private *p =3D watchdog_get_drvdata(wd_d=
ev);
>  =A0=A0=A0=A0=A0 unsigned int val;
>=20
> +=A0=A0=A0=A0 /* force_no_reboot will prevent to unset NO_REBOOT bit */
> +=A0=A0=A0=A0 if (force_no_reboot)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;
> +
It seems to me that this flag prevents the watchdog from being started, and=
 on top it would return an unreasonable error (-EIO).

I don't see the point of this patch, sorry.

Guenter

>  =A0=A0=A0=A0=A0 spin_lock(&p->io_lock);
>=20
>  =A0=A0=A0=A0=A0 iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout); @@ -=
250,7=20
> +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>  =A0=A0=A0=A0=A0 /* disable chipset's NO_REBOOT bit */
>  =A0=A0=A0=A0=A0 if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&p->io_lock);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("failed to reset NO_REBOOT flag, r=
eboot disabled by=20
> hardware/BIOS\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("failed to reset NO_REBOOT flag, r=
eboot disabled by=20
> +hardware/BIOS/rc_cmd\n");
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>  =A0=A0=A0=A0=A0 }
>=20
> --
> 2.7.4
>=20
