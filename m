Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:45960 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752433AbcBETtM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 14:49:12 -0500
Date: Fri, 5 Feb 2016 13:49:10 -0600
From: Josh Cartwright <joshc@ni.com>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [RFC 1/4] watchdog: ni9x3x_wdt: Add NI 903x/913x watchdog driver
Message-ID: <20160205194910.GA9579@jcartwri.amer.corp.natinst.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
MIME-Version: 1.0
In-Reply-To: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 07:28:00PM -0600, Kyle Roeschley wrote:
> Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
> time controllers.
>=20
> Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
[..]
> +++ b/drivers/watchdog/ni9x3x_wdt.c
> @@ -0,0 +1,264 @@
[..]
> +#define NIWD_CONTROL_MODE		0x80
> +#define NIWD_CONTROL_PROC_RESET		0x20
> +#define NIWD_CONTROL_PET		0x10
> +#define NIWD_CONTROL_RUNNING		0x08
> +#define NIWD_CONTROL_CAPTURECOUNTER	0x04
> +#define NIWD_CONTROL_RESET		0x02
> +#define NIWD_CONTROL_ALARM		0x01
> +
> +#define NIWD_PERIOD_NS		30720
> +#define NIWD_MIN_TIMEOUT	1
> +#define NIWD_MAX_TIMEOUT	515
> +#define NIWD_DEFAULT_TIMEOUT	60
> +
> +#define NI9X3X_WDT_NAME		"ni9x3x_wdt"
> +
> +#define to_ni9x3x_wdt(_wdog)	container_of(_wdog, struct ni9x3x_wdt, wdog)
> +
> +struct ni9x3x_wdt {
> +	struct acpi_device *acpi_device;

Probably a bit easier if you just cache the 'struct device *' instead.
Or, just use wdog.parent.

> +	u16 io_base;
> +	u16 io_size;

You don't actually need io_size after probe().  I'm wondering if you
could just move the devm_request_region directly into your
acpi_walk_resources callback and drop this.

> +	spinlock_t lock;

This isn't used at all?  (I'm assuming it might be used in a later
patch, but if so, it should be introduced there).

> +	struct watchdog_device wdog;
> +};
> +
> +static void ni9x3x_wdt_start(struct ni9x3x_wdt *wdt)
> +{
> +	u8 control =3D inb(wdt->io_base + NIWD_CONTROL);
> +
> +	outb(control | NIWD_CONTROL_RESET, wdt->io_base + NIWD_CONTROL);
> +	outb(control | NIWD_CONTROL_PET, wdt->io_base + NIWD_CONTROL);
> +}
> +
> +static int ni9x3x_wdt_wdd_set_timeout(struct watchdog_device *wdd,
> +				      unsigned int timeout)
> +{
> +	struct ni9x3x_wdt *wdt =3D to_ni9x3x_wdt(wdd);
> +	u32 counter =3D timeout * (1000000000 / NIWD_PERIOD_NS);
> +
> +	outb(((0x00FF0000 & counter) >> 16), wdt->io_base + NIWD_SEED2);
> +	outb(((0x0000FF00 & counter) >> 8), wdt->io_base + NIWD_SEED1);
> +	outb((0x000000FF & counter), wdt->io_base + NIWD_SEED0);
> +
> +	return 0;
> +}
> +
> +static unsigned int ni9x3x_wdt_wdd_get_timeleft(struct watchdog_device *=
wdd)
> +{
> +	struct ni9x3x_wdt *wdt =3D to_ni9x3x_wdt(wdd);
> +	u8 control, counter0, counter1, counter2;
> +	u32 counter;
> +
> +	control =3D inb(wdt->io_base + NIWD_CONTROL);
> +	control |=3D NIWD_CONTROL_CAPTURECOUNTER;
> +	outb(control, wdt->io_base + NIWD_CONTROL);
> +
> +	counter2 =3D inb(wdt->io_base + NIWD_COUNTER2);
> +	counter1 =3D inb(wdt->io_base + NIWD_COUNTER1);
> +	counter0 =3D inb(wdt->io_base + NIWD_COUNTER0);
> +
> +	counter =3D (counter2 << 16) | (counter1 << 8) | counter0;
> +	counter =3D (counter * (u64)NIWD_PERIOD_NS) / 1000000000;
> +
> +	return (unsigned int)counter;

Nit: unnecessary cast.

> +}
[..]
> +static int ni9x3x_wdt_acpi_add(struct acpi_device *device)
> +{
> +	struct ni9x3x_wdt *wdt;
> +	acpi_status status;
> +	int ret;
> +
> +	wdt =3D devm_kzalloc(&device->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	device->driver_data =3D wdt;
> +	wdt->acpi_device =3D device;
> +
> +	status =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +				     ni9x3x_wdt_resources, wdt);
> +	if (ACPI_FAILURE(status) || wdt->io_base =3D=3D 0 ||
> +	    wdt->io_size !=3D NIWD_IO_SIZE) {
> +		dev_err(&device->dev, "failed to get resources\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!devm_request_region(&device->dev, wdt->io_base, wdt->io_size,
> +				 NI9X3X_WDT_NAME)) {
> +		dev_err(&device->dev, "failed to get memory region\n");
> +		return -EBUSY;
> +	}
> +
> +	spin_lock_init(&wdt->lock);
> +
> +	wdt->wdog.info =3D &ni9x3x_wdt_wdd_info;
> +	wdt->wdog.ops =3D &ni9x3x_wdt_wdd_ops;
> +	wdt->wdog.min_timeout =3D NIWD_MIN_TIMEOUT;
> +	wdt->wdog.max_timeout =3D NIWD_MAX_TIMEOUT;
> +	wdt->wdog.timeout =3D NIWD_DEFAULT_TIMEOUT;
> +	wdt->wdog.parent =3D &device->dev;
> +
> +	ret =3D watchdog_register_device(&wdt->wdog);
> +	if (ret) {
> +		dev_err(&device->dev, "failed to register watchdog\n");
> +		return ret;
> +	}
> +
> +	/* Switch from boot mode to user mode */
> +	outb(NIWD_CONTROL_RESET | NIWD_CONTROL_MODE,
> +	     wdt->io_base + NIWD_CONTROL);
> +
> +	dev_info(&wdt->acpi_device->dev, "IO range 0x%04X-0x%04X\n",
> +		 wdt->io_base, wdt->io_base + wdt->io_size - 1);

dev_dbg(), please.  Booting is loud enough.

[..]
> +static struct acpi_driver ni9x3x_wdt_acpi_driver =3D {
> +	.name =3D NI9X3X_WDT_NAME,
> +	.ids =3D ni9x3x_wdt_device_ids,
> +	.ops =3D {
> +		.add =3D ni9x3x_wdt_acpi_add,
> +		.remove =3D ni9x3x_wdt_acpi_remove,
> +		},
> +};
> +
> +static int __init ni9x3x_wdt_init(void)
> +{
> +	return acpi_bus_register_driver(&ni9x3x_wdt_acpi_driver);
> +}
> +
> +static void __exit ni9x3x_wdt_exit(void)
> +{
> +	acpi_bus_unregister_driver(&ni9x3x_wdt_acpi_driver);
> +}
> +
> +module_init(ni9x3x_wdt_init);
> +module_exit(ni9x3x_wdt_exit);

module_acpi_driver(ni9x3x_wdt_acpi_driver)?

> +
> +MODULE_DEVICE_TABLE(acpi, ni9x3x_wdt_device_ids);

Suggestion: move this right below the table.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWtPyzAAoJEKp7ZBKwQFAr5cMH/jgO5wOKJIa0L8fVDAqUfSW3
ku+QOFtK5fSj/ErNQcBZ1W+kDrgyhIdG2ftT3ouFggNhMqfyH3VnWD7ky7Rwaxq5
89f4NZZquxyRN3Tfq/71cGScJq+XKdNsL5dHbCEzHu+P8Vv0OqoLwxtcVIhCf0C+
h6vGFF4bvQkd+ZTACeid7rsrAqrzJUKp2V19OMWDb0AX7LCu4aepoq/iEzG+PuWS
xpCDE5ZEh6g/1U4+Agislko/xSRFt3LGyozs4ZZjnaD6zkKZTeiL3aRmaWuDwD0z
mTc66oc3pLaaouYaDkL6o40C8aXXjx0U9tiQh+2s9MSPCaVHLUDPm1WS9aZHvp0=
=mqSr
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
