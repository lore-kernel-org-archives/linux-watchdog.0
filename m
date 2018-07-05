Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
Date: Thu, 5 Jul 2018 06:21:37 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D0E@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
 <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
In-Reply-To: <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi, Roeck

Yes, this patch submitted more than 1 year ago in our internal tree, I just=
 tested latest 4.18 kernel, even without this patch, there is no error.
So I am ok to reject this patch.

Thanks
Tim

-----Original Message-----
From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
Sent: Monday, July 2, 2018 9:17 PM
To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-w=
atchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: change ITCO_WDT type from tristate to bool

On 07/02/2018 01:18 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
>=20
> tristate will allow kernel config it to M and build ko file, this will=20
> cause build allmodconfig errors as necessary symbols have not been=20
> exported.
> change it to bool, only allow config ITCO_WDT to yes/no.
>=20
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>

This works today. I don't see a point changing it, and I am wary doing so.
There are systems where the iTCO watchdog doesn't work (I own one of those)=
, even though it instantiates, and I am wary of force-loading it.

Besides, you don't explain which "necessary symbols have not been exported"=
.
I do not plan to spend time trying to find out what those symbols are, and =
why this would suddenly be a problem.

Guenter

> ---
>  =A0drivers/watchdog/Kconfig | 2 +-
>  =A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index=20
> 9af07fd..f991e93 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1049,7 +1049,7 @@ config INTEL_MID_WATCHDOG
>  =A0=A0=A0=A0=A0 =A0 To compile this driver as a module, choose M here.
>=20
>  =A0config ITCO_WDT
> -=A0=A0=A0=A0 tristate "Intel TCO Timer/Watchdog"
> +=A0=A0=A0=A0 bool "Intel TCO Timer/Watchdog"
>  =A0=A0=A0=A0=A0 depends on (X86 || IA64) && PCI
>  =A0=A0=A0=A0=A0 select WATCHDOG_CORE
>  =A0=A0=A0=A0=A0 depends on I2C || I2C=3Dn
> --
> 2.7.4
>=20
