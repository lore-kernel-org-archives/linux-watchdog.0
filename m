Return-Path: <philipp_subx@redfish-solutions.com>
Return-path: <philipp_subx@redfish-solutions.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] watchdog: iTCO_wdt: Introduce panic_on_timeout module param
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <20161205224815.23335-1-jpitti@cisco.com>
Date: Mon, 18 Sep 2017 20:52:26 -0600
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        xe-kernel@external.cisco.com, jpitti@mvista.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAF7C8B1-7A8B-4EBB-9FD7-39A72F669C76@redfish-solutions.com>
References: <20161205224815.23335-1-jpitti@cisco.com>
To: Julius Hemanth Pitti <jpitti@cisco.com>
List-ID: <linux-watchdog@vger.kernel.org>

Sorry for being late to the party=E2=80=A6

I tried to use this patch backported to 4.9.49 but could only get the =
system to reset (presumably the SMI but not certain since I=E2=80=99m =
not that current on BMC/SMI architecture) when it hung.

It=E2=80=99s a Lanner FW-8771 with AMI BIOS 4.6.5 on a Xeon E3-1225 v3.

Also, it seems to me that the TCO stuff has several versions (that =
affect bit placement and semantics) but I=E2=80=99m assuming that this =
code hasn=E2=80=99t been tested on all versions?

Thus special handling might be required based on the generation of TCO =
that=E2=80=99s on-chip which I=E2=80=99m not seeing here.  What =
processor was this code developed/tested on?

Comments on the particulars of the code itself inline.


> On Dec 5, 2016, at 3:48 PM, Julius Hemanth Pitti <jpitti@cisco.com> =
wrote:
>=20
> Currently iTCO_wdt silently resets the board when timeout
> occurs.
>=20
> This patch introduces new "panic_on_timeout" module param,
> which when set allows the iTCO_wdt to call panic when
> watchdog timeout occurs, this help to boot to crash
> kernel and collect core dump for further analysis.
>=20
> Cc: xe-kernel@external.cisco.com
> Cc: jpitti@mvista.com
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> ---
> drivers/watchdog/iTCO_wdt.c | 61 =
+++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 06fcb6c..23ddcf4 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -66,6 +66,7 @@
> #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... =
*/
> #include <linux/uaccess.h>		/* For copy_to_user/put_user/... =
*/
> #include <linux/io.h>			/* For inb/outb/... */
> +#include <linux/nmi.h>
> #include <linux/platform_data/itco_wdt.h>
>=20
> #include "iTCO_vendor.h"
> @@ -76,6 +77,24 @@
> /* SMI Control and Enable Register */
> #define SMI_EN		(iTCO_wdt_private.smi_res->start)
>=20
> +static int panic_on_timeout;


Don=E2=80=99t seem the point of making this =E2=80=98int=E2=80=99 rather =
than =E2=80=98bool=E2=80=99.


> +module_param(panic_on_timeout, int, 0);


Ditto


> +MODULE_PARM_DESC(panic_on_timeout,
> +		 "Panic on NMI instead of Reset (1 =3D panic), =
default=3D0.");
> +
> +/* NMI2SMI_EN is bit 9 of TCO1_CNT register
> + * Read/Write
> + * 0 =3D Normal NMI functionality.
> + * 1 =3D Forces all NMIs to instead cause SMIs
> + *     This depends on NMI_EN and GBL_SMI_EN bits.
> + */
> +#define NMI2SMI_EN	(1 << 9)
> +
> +/* NMI_NOW is bit 8 of TCO1_CNT register.
> + * Read/'Write to Clear'
> + */
> +#define NMI_NOW		(1 << 8)
> +
> #define TCO_RLD		(TCOBASE + 0x00) /* TCO Timer Reload and =
Curr. Value */
> #define TCOv1_TMR	(TCOBASE + 0x01) /* TCOv1 Timer Initial Value	=
*/
> #define TCO_DAT_IN	(TCOBASE + 0x02) /* TCO Data In Register	=
*/
> @@ -236,6 +255,15 @@ static int iTCO_wdt_start(struct watchdog_device =
*wd_dev)
> 	val &=3D 0xf7ff;
> 	outw(val, TCO1_CNT);
> 	val =3D inw(TCO1_CNT);
> +
> +	if (panic_on_timeout) {
> +		/* Make sure NMIs are allowed to fire */
> +		if (NMI2SMI_EN & val) {


The Yoda notation was already called out=E2=80=A6


> +			val &=3D ~(NMI2SMI_EN);


=E2=80=A6 as were the extraneous parens.


> +			outw(val, TCO1_CNT);
> +			pr_info("NMIs are no longer routed to SMIs\n");
> +		}
> +	}
> 	spin_unlock(&iTCO_wdt_private.io_lock);
>=20
> 	if (val & 0x0800)


Do we need:

+@@ -372,6 +373,7 @@ static unsigned int iTCO_wdt_get_timelef
+=20
+ static const struct watchdog_info ident =3D {
+       .options =3D              WDIOF_SETTIMEOUT |
++                              WDIOF_PRETIMEOUT |
+                               WDIOF_KEEPALIVEPING |
+                               WDIOF_MAGICCLOSE,
+       .firmware_version =3D     0,

also?  Because without WDIOF_PRETIMEOUT, it seems that =
watchdog_set_pretimeout() would return
-EOPNOTSUPP when you try to do the ioctl(WDIOC_SETPRETIMEOUT)=E2=80=A6


> @@ -422,6 +450,26 @@ static void iTCO_wdt_cleanup(void)
> 	iTCO_wdt_private.gcs_pmc =3D NULL;
> }
>=20
> +/*
> + * iTCO_wdt_timeout_handler: Handler for watchdog timeout NMI event.
> + */
> +int iTCO_wdt_timeout_handler(unsigned int ulReason, struct pt_regs =
*regs)
> +{
> +	unsigned long val32 =3D inw(TCO1_CNT);
> +
> +	if (val32 & NMI_NOW) {
> +		/* Clear NMI - Bit 8 within TCO1_CNT is write to clear =
*/
> +		outw(val32, TCO1_CNT);
> +
> +		/* Crash the system */
> +		nmi_panic(regs, "iTCO_wdt: Watchdog timeout");
> +
> +		/* Never returns */
> +		return NMI_HANDLED;
> +	}
> +	return NMI_DONE;
> +}
> +
> static int iTCO_wdt_probe(struct platform_device *dev)
> {
> 	int ret =3D -ENODEV;
> @@ -552,11 +600,21 @@ static int iTCO_wdt_probe(struct platform_device =
*dev)
> 		goto unreg_tco;
> 	}
>=20
> +	if (panic_on_timeout) {
> +		ret =3D register_nmi_handler(NMI_UNKNOWN, =
iTCO_wdt_timeout_handler, 0, "iTCO_wdt");
> +		if (ret !=3D 0) {
> +			pr_err("cannot register NMI Handler for iTCO_wdt =
watchdog (err=3D%d)\n", ret);
> +			goto unreg_wd;
> +		}
> +	}
> +
> 	pr_info("initialized. heartbeat=3D%d sec (nowayout=3D%d)\n",
> 		heartbeat, nowayout);
>=20
> 	return 0;
>=20
> +unreg_wd:
> +	watchdog_unregister_device(&iTCO_wdt_watchdog_dev);
> unreg_tco:
> 	release_region(iTCO_wdt_private.tco_res->start,
> 			resource_size(iTCO_wdt_private.tco_res));
> @@ -581,6 +639,9 @@ static int iTCO_wdt_probe(struct platform_device =
*dev)
>=20
> static int iTCO_wdt_remove(struct platform_device *dev)
> {
> +	if (panic_on_timeout)
> +		unregister_nmi_handler(NMI_UNKNOWN, "iTCO_wdt");
> +
> 	if (iTCO_wdt_private.tco_res || iTCO_wdt_private.smi_res)
> 		iTCO_wdt_cleanup();
>=20
