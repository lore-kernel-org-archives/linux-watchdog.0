Return-Path: <baofeng.tian@intel.com>
Return-path: <baofeng.tian@intel.com>
From: "Tian, Baofeng" <baofeng.tian@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: add NMI handler for iTCO watchdog
Date: Thu, 5 Jul 2018 06:43:06 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D57@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE7E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C063@shsmsx102.ccr.corp.intel.com>
 <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
In-Reply-To: <cf1a7c57-4b65-eba1-a420-103ab40f7103@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi, Roeck

Yes, as long as NMI interrupt generated, this handler will be called before=
 reboot.
We have another patch to handle NMI generation on X86 platform, it use perf=
 event to generate NMI in TCO WDT driver.=20
Will submit later.

Thanks
Tim

-----Original Message-----
From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
Sent: Monday, July 2, 2018 9:38 PM
To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-w=
atchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add NMI handler for iTCO watchdog

On 07/02/2018 01:15 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: add NMI handler for iTCO watchdog
>=20
> Add a NMI handler in iTCO watchdog driver probe.
> When iTCO watchdog timeout, it gernerate a NMI interrupt.

generate

Does it always do that ? My understanding is that it has to be configured t=
o do so.

> The NMI handler will be called when iTCO NMI interrupt triggered.
>=20
> In the NMI handler, it will dump all cpu backtraces and call panic to=20
> continue reboot.
>=20
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com=20
> <mailto:baofeng.tian@intel.com>>

As with other patches, the e-mail address is messed up.

If I recall correctly, we already had a similar patch trying to introduce M=
NI handling to the driver a long time ago. I don't recall why it did not ma=
ke it in, but there must be some caveat. Someone will have to look that up =
and explain why this submission is different and works. It would be great i=
f you can do that; otherwise I'll have to do it. Given my time constraints,=
 that may take a while.

> ---
>  =A0drivers/watchdog/iTCO_wdt.c | 53=20
> +++++++++++++++++++++++++++++++++++++++++++++
>  =A01 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c=20
> index 347f038..7a79d0f 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -68,6 +68,8 @@
>  =A0#include <linux/io.h>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* For i=
nb/outb/... */
>  =A0#include <linux/platform_data/itco_wdt.h>
>=20
> +#include <linux/nmi.h>
> +#include <asm/nmi.h>
>  =A0#include "iTCO_vendor.h"
>=20
>  =A0/* Address definitions for the TCO */ @@ -86,6 +88,11 @@
>  =A0#define TCO2_CNT(p)=A0=A0=A0 (TCOBASE(p) + 0x0a) /* TCO2 Control Regi=
ster=A0=A0=A0=20
> */
>  =A0#define TCOv2_TMR(p)=A0=A0 (TCOBASE(p) + 0x12) /* TCOv2 Timer Initial=
=20
> Value*/
>=20
> +#define TCO_RLD_sub(base)=A0=A0=A0 (base + 0x00) /* TCO Timer Reload/Cur=
r.=20
> +Value */ #define TCO1_STS_sub(base)=A0=A0 (base + 0x04) /* TCO1 Status=20
> +Register=A0=A0=A0=A0 */ #define TCOv2_TMR_sub(base)=A0 (base + 0x12) /* =
TCOv2=20
> +Timer Initial Value*/
> +
> +
>  =A0/* internal variables */
>  =A0struct iTCO_wdt_private {
>  =A0=A0=A0=A0=A0 struct watchdog_device wddev;
> @@ -112,6 +119,14 @@ struct iTCO_wdt_private {
>  =A0=A0=A0=A0=A0 int (*update_no_reboot_bit)(void *p, bool set);
>  =A0};
>=20
> +static struct {
> +=A0=A0=A0=A0 resource_size_t tco_base_address;
> +=A0=A0=A0=A0 unsigned int iTCO_version;

Where is this variable used ?

> +=A0=A0=A0=A0 bool pretimeout_occurred;
> +=A0=A0=A0=A0 unsigned int second_to_ticks;

What is the point of this variable ? It is used as constant.

> +} iTCO_wdt_sub;
> +
> +

Checkpatch should tell you to avoid more than one empty line.

>  =A0/* module parameters */
>  =A0#define WATCHDOG_TIMEOUT 30=A0 /* 30 sec default heartbeat */
>  =A0static int heartbeat =3D WATCHDOG_TIMEOUT;=A0 /* in seconds */ @@ -42=
2,6=20
> +437,33 @@ static const struct watchdog_ops iTCO_wdt_ops =3D {
>  =A0=A0=A0=A0=A0 .get_timeleft =3D=A0=A0=A0=A0=A0=A0=A0=A0 iTCO_wdt_get_t=
imeleft,
>  =A0};
>=20
> +static int iTCO_pretimeout(unsigned int cmd, struct pt_regs=20
> +*unused_regs) {
> +=A0=A0=A0=A0 resource_size_t tco_base_address;

What is the point of this variable ?

> +
> +=A0=A0=A0=A0 /* Prevent re-entrance */
> +=A0=A0=A0=A0 if (iTCO_wdt_sub.pretimeout_occurred)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NMI_HANDLED;
> +

This is odd and suggests that something may be wrong. There should not be m=
ore than one NMI.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tco_base_address =3D iTCO_wdt_sub.tco_bas=
e_address;

At the very least column alignment is wrong.

> +
> +=A0=A0=A0=A0 /* Check the NMI is from the TCO first expiration */
> +=A0=A0=A0=A0 if (inw(TCO1_STS_sub(tco_base_address)) & 0x8) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iTCO_wdt_sub.pretimeout_occurred =3D true=
;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Forward next expiration */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 outw(iTCO_wdt_sub.second_to_ticks,=20
> +TCOv2_TMR_sub(tco_base_address));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 outw(0x01, TCO_RLD_sub(tco_base_address))=
;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trigger_all_cpu_backtrace();

A wild guess is that arch_trigger_cpumask_backtrace() is not exported.
That means you can not call that function from here, and it strongly sugges=
ts that the function is not supposed to be called from drivers, including w=
atchdog_drivers. Besides, panic() already triggers a backtrace.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 panic_timeout =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 panic("Kernel Watchdog");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NMI_HANDLED;
> +=A0=A0=A0=A0 }
> +
> +=A0=A0=A0=A0 return NMI_DONE;
> +}
> +
>  =A0/*
>  =A0 *=A0=A0 Init & exit routines
>  =A0 */
> @@ -555,6 +597,17 @@ static int iTCO_wdt_probe(struct platform_device=20
> *pdev)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
>  =A0=A0=A0=A0=A0 }
>=20
> +=A0=A0=A0 /* init vars that used for nmi handler */
> +=A0=A0=A0=A0 iTCO_wdt_sub.iTCO_version =3D p->iTCO_version;
> +=A0=A0=A0=A0 iTCO_wdt_sub.second_to_ticks =3D seconds_to_ticks(p, 10);

Where does the 10 come from ? What is the rationale ?

> +=A0=A0=A0=A0 iTCO_wdt_sub.tco_base_address =3D TCOBASE(p);
> +
> +=A0=A0=A0=A0 ret =3D register_nmi_handler(NMI_LOCAL, iTCO_pretimeout, 0,=
=20
> +"iTCO_wdt");
> +=A0=A0=A0=A0 if (ret !=3D 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("cannot register nmi handler (err=
=3D%d)\n", ret);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;

Return an error and leave the watchdog driver registered ? That will cause =
some nice crashes.

> +=A0=A0=A0=A0 }
> +
>  =A0=A0=A0=A0=A0 pr_info("initialized. heartbeat=3D%d sec (nowayout=3D%d)=
\n",
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 heartbeat, nowayout);
>=20
> --
> 2.7.4
>=20
