Return-path: <tomas.winkler@intel.com>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@iguana.be>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v3 3/8] watchdog: mei_wdt: implement MEI iAMT
 watchdog driver
Date: Tue, 22 Dec 2015 07:19:57 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B540F6079@hasmsx108.ger.corp.intel.com>
References: <1450739881-3923-1-git-send-email-tomas.winkler@intel.com>
 <1450739881-3923-4-git-send-email-tomas.winkler@intel.com>
 <5678D85E.30101@roeck-us.net>
In-Reply-To: <5678D85E.30101@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


>=20
> On 12/21/2015 03:17 PM, Tomas Winkler wrote:
> > Create a driver with the generic watchdog interface
> > for the MEI iAMT watchdog device.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> > V2: The watchdog device is no longer dynamically allocated in separate
> structure
> > V3: Revert back to dynamically allocated watchdog device wrapper
> >
> >   Documentation/misc-devices/mei/mei.txt |  12 +-
> >   MAINTAINERS                            |   1 +
> >   drivers/watchdog/Kconfig               |  15 +
> >   drivers/watchdog/Makefile              |   1 +
> >   drivers/watchdog/mei_wdt.c             | 481
> +++++++++++++++++++++++++++++++++
> >   5 files changed, 504 insertions(+), 6 deletions(-)
> >   create mode 100644 drivers/watchdog/mei_wdt.c
> >
> > diff --git a/Documentation/misc-devices/mei/mei.txt b/Documentation/mis=
c-
> devices/mei/mei.txt
> > index 91c1fa34f48b..2b80a0cd621f 100644
> > --- a/Documentation/misc-devices/mei/mei.txt
> > +++ b/Documentation/misc-devices/mei/mei.txt
> > @@ -231,15 +231,15 @@ IT knows when a platform crashes even when there
> is a hard failure on the host.
> >   The Intel AMT Watchdog is composed of two parts:
> >   	1) Firmware feature - receives the heartbeats
> >   	   and sends an event when the heartbeats stop.
> > -	2) Intel MEI driver - connects to the watchdog feature, configures th=
e
> > -	   watchdog and sends the heartbeats.
> > +	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
> > +	   configures the watchdog and sends the heartbeats.
> >
> > -The Intel MEI driver uses the kernel watchdog API to configure the Int=
el AMT
> > -Watchdog and to send heartbeats to it. The default timeout of the
> > +The Intel iAMT watchdog MEI driver uses the kernel watchdog API to con=
figure
> > +the Intel AMT Watchdog and to send heartbeats to it. The default timeo=
ut of
> the
> >   watchdog is 120 seconds.
> >
> > -If the Intel AMT Watchdog feature does not exist (i.e. the connection =
failed),
> > -the Intel MEI driver will disable the sending of heartbeats.
> > +If the Intel AMT is not enabled in the firmware then the watchdog clie=
nt won't
> enumerate
> > +on the me client bus and watchdog devices won't be exposed.
> >
> >
> >   Supported Chipsets
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9bff63cf326e..e655625c2c16 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5666,6 +5666,7 @@ S:	Supported
> >   F:	include/uapi/linux/mei.h
> >   F:	include/linux/mei_cl_bus.h
> >   F:	drivers/misc/mei/*
> > +F:	drivers/watchdog/mei_wdt.c
> >   F:	Documentation/misc-devices/mei/*
> >
> >   INTEL MIC DRIVERS (mic)
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 1c427beffadd..8ac51d69785c 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1154,6 +1154,21 @@ config SBC_EPX_C3_WATCHDOG
> >   	  To compile this driver as a module, choose M here: the
> >   	  module will be called sbc_epx_c3.
> >
> > +config INTEL_MEI_WDT
> > +	tristate "Intel MEI iAMT Watchdog"
> > +	depends on INTEL_MEI && X86
> > +	select WATCHDOG_CORE
> > +	---help---
> > +	  A device driver for the Intel MEI iAMT watchdog.
> > +
> > +	  The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
> > +	  Whenever the OS hangs or crashes, iAMT will send an event
> > +	  to any subscriber to this event. The watchdog doesn't reset the
> > +	  the platform.
> > +
> > +	  To compile this driver as a module, choose M here:
> > +	  the module will be called mei_wdt.
> > +
> >   # M32R Architecture
> >
> >   # M68K Architecture
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 53d4827ddfe1..9069c9dd8aa8 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -123,6 +123,7 @@ obj-$(CONFIG_MACHZ_WDT) +=3D machzwd.o
> >   obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) +=3D sbc_epx_c3.o
> >   obj-$(CONFIG_INTEL_SCU_WATCHDOG) +=3D intel_scu_watchdog.o
> >   obj-$(CONFIG_INTEL_MID_WATCHDOG) +=3D intel-mid_wdt.o
> > +obj-$(CONFIG_INTEL_MEI_WDT) +=3D mei_wdt.o
> >
> >   # M32R Architecture
> >
> > diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> > new file mode 100644
> > index 000000000000..5b28a1e95ac1
> > --- /dev/null
> > +++ b/drivers/watchdog/mei_wdt.c
> > @@ -0,0 +1,481 @@
> > +/*
> > + * Intel Management Engine Interface (Intel MEI) Linux driver
> > + * Copyright (c) 2015, Intel Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> for
> > + * more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/watchdog.h>
> > +
> > +#include <linux/uuid.h>
> > +#include <linux/mei_cl_bus.h>
> > +
> > +/*
> > + * iAMT Watchdog Device
> > + */
> > +#define INTEL_AMT_WATCHDOG_ID "iamt_wdt"
> > +
> > +#define MEI_WDT_DEFAULT_TIMEOUT   120  /* seconds */
> > +#define MEI_WDT_MIN_TIMEOUT       120  /* seconds */
> > +#define MEI_WDT_MAX_TIMEOUT     65535  /* seconds */
> > +
> > +/* Commands */
> > +#define MEI_MANAGEMENT_CONTROL 0x02
> > +
> > +/* MEI Management Control version number */
> > +#define MEI_MC_VERSION_NUMBER  0x10
> > +
> > +/* Sub Commands */
> > +#define MEI_MC_START_WD_TIMER_REQ  0x13
> > +#define MEI_MC_STOP_WD_TIMER_REQ   0x14
> > +
> > +/**
> > + * enum mei_wdt_state - internal watchdog state
> > + *
> > + * @MEI_WDT_IDLE: wd is idle and not opened
> > + * @MEI_WDT_START: wd was opened, start was called
> > + * @MEI_WDT_RUNNING: wd is expecting keep alive pings
> > + * @MEI_WDT_STOPPING: wd is stopping and will move to IDLE
> > + */
> > +enum mei_wdt_state {
> > +	MEI_WDT_IDLE,
> > +	MEI_WDT_START,
> > +	MEI_WDT_RUNNING,
> > +	MEI_WDT_STOPPING,
> > +};
> > +
> > +struct mei_wdt;
> > +
> > +/**
> > + * struct mei_wdt_dev - watchdog device wrapper
> > + *
> > + * @wdd: watchdog device
> > + * @wdt: back pointer to mei_wdt driver
> > + * @refcnt: reference counter
> > + */
> > +struct mei_wdt_dev {
> > +	struct watchdog_device wdd;
> > +	struct mei_wdt *wdt;
> > +	struct kref refcnt;
> > +};
> > +
> > +/**
> > + * struct mei_wdt - mei watchdog driver
> > + * @mwd: watchdog device wrapper
> > + *
> > + * @cldev: mei watchdog client device
> > + * @state: watchdog internal state
> > + * @timeout: watchdog current timeout
> > + */
> > +struct mei_wdt {
> > +	struct mei_wdt_dev *mwd;
> > +
> > +	struct mei_cl_device *cldev;
> > +	enum mei_wdt_state state;
> > +	u16 timeout;
> > +};
> > +
> > +/*
> > + * struct mei_mc_hdr - Management Control Command Header
> > + *
> > + * @command: Management Control (0x2)
> > + * @bytecount: Number of bytes in the message beyond this byte
> > + * @subcommand: Management Control Subcommand
> > + * @versionnumber: Management Control Version (0x10)
> > + */
> > +struct mei_mc_hdr {
> > +	u8 command;
> > +	u8 bytecount;
> > +	u8 subcommand;
> > +	u8 versionnumber;
> > +};
> > +
> > +/**
> > + * struct mei_wdt_start_request watchdog start/ping
> > + *
> > + * @hdr: Management Control Command Header
> > + * @timeout: timeout value
> > + * @reserved: reserved (legacy)
> > + */
> > +struct mei_wdt_start_request {
> > +	struct mei_mc_hdr hdr;
> > +	u16 timeout;
> > +	u8 reserved[17];
> > +} __packed;
> > +
> > +/**
> > + * struct mei_wdt_stop_request - watchdog stop
> > + *
> > + * @hdr: Management Control Command Header
> > + */
> > +struct mei_wdt_stop_request {
> > +	struct mei_mc_hdr hdr;
> > +} __packed;
> > +
> > +/**
> > + * mei_wdt_ping - send wd start/ping command
> > + *
> > + * @wdt: mei watchdog device
> > + *
> > + * Return: 0 on success,
> > + *         negative errno code on failure
> > + */
> > +static int mei_wdt_ping(struct mei_wdt *wdt)
> > +{
> > +	struct mei_wdt_start_request req;
> > +	const size_t req_len =3D sizeof(req);
> > +	int ret;
> > +
> > +	memset(&req, 0, req_len);
> > +	req.hdr.command =3D MEI_MANAGEMENT_CONTROL;
> > +	req.hdr.bytecount =3D req_len - offsetof(struct mei_mc_hdr,
> subcommand);
> > +	req.hdr.subcommand =3D MEI_MC_START_WD_TIMER_REQ;
> > +	req.hdr.versionnumber =3D MEI_MC_VERSION_NUMBER;
> > +	req.timeout =3D wdt->timeout;
> > +
> > +	ret =3D mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mei_wdt_stop - send wd stop command
> > + *
> > + * @wdt: mei watchdog device
> > + *
> > + * Return: 0 on success,
> > + *         negative errno code on failure
> > + */
> > +static int mei_wdt_stop(struct mei_wdt *wdt)
> > +{
> > +	struct mei_wdt_stop_request req;
> > +	const size_t req_len =3D sizeof(req);
> > +	int ret;
> > +
> > +	memset(&req, 0, req_len);
> > +	req.hdr.command =3D MEI_MANAGEMENT_CONTROL;
> > +	req.hdr.bytecount =3D req_len - offsetof(struct mei_mc_hdr,
> subcommand);
> > +	req.hdr.subcommand =3D MEI_MC_STOP_WD_TIMER_REQ;
> > +	req.hdr.versionnumber =3D MEI_MC_VERSION_NUMBER;
> > +
> > +	ret =3D mei_cldev_send(wdt->cldev, (u8 *)&req, req_len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mei_wdt_ops_start - wd start command from the watchdog core.
> > + *
> > + * @wdd: watchdog device
> > + *
> > + * Return: 0 on success or -ENODEV;
> > + */
> > +static int mei_wdt_ops_start(struct watchdog_device *wdd)
> > +{
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +	struct mei_wdt *wdt;
> > +
> > +	if (!mwd)
> > +		return -ENODEV;
> > +
> I don't find a code path where this can be NULL. I also checked later pat=
ches,
> but I just don't see it.
>=20
> Can you clarify how this can happen ? If this is just for safety, it shou=
ld go.
> We would _want_ the driver to crash unless this is a valid condition.
>=20
> Several other similar checks below.

Yes, this can happen and as far I remember it does as we are unregistering =
the device while the watchdog core is still=20
holding on wdd.  Also I prefer not crashing the driver and the whole kernel=
 with it, this is API should check its parameters.=20

>=20
> > +	wdt =3D mwd->wdt;
> > +
> > +	wdt->state =3D MEI_WDT_START;
> > +	wdd->timeout =3D wdt->timeout;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mei_wdt_ops_stop - wd stop command from the watchdog core.
> > + *
> > + * @wdd: watchdog device
> > + *
> > + * Return: 0 if success, negative errno code for failure
> > + */
> > +static int mei_wdt_ops_stop(struct watchdog_device *wdd)
> > +{
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +	struct mei_wdt *wdt;
> > +	int ret;
> > +
> > +	if (!mwd)
> > +		return -ENODEV;
> > +
> Same here.
>=20
> > +	wdt =3D mwd->wdt;
> > +
> > +	if (wdt->state !=3D MEI_WDT_RUNNING)
> > +		return 0;
> > +
> > +	wdt->state =3D MEI_WDT_STOPPING;
> > +
> > +	ret =3D mei_wdt_stop(wdt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	wdt->state =3D MEI_WDT_IDLE;
> > +
> Just wondering ... is MEI_WDT_STOPPING necessary ?
> At least from an ops perspective, this function is atomic
> (protected by a mutex in the watchdog core).
>=20
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mei_wdt_ops_ping - wd ping command from the watchdog core.
> > + *
> > + * @wdd: watchdog device
> > + *
> > + * Return: 0 if success, negative errno code on failure
> > + */
> > +static int mei_wdt_ops_ping(struct watchdog_device *wdd)
> > +{
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +	struct mei_wdt *wdt;
> > +	int ret;
> > +
> > +	if (!mwd)
> > +		return -ENODEV;
> > +
> And here.
>=20
> > +	wdt =3D mwd->wdt;
> > +
> > +	if (wdt->state !=3D MEI_WDT_START && wdt->state !=3D
> MEI_WDT_RUNNING)
> > +		return 0;
> > +
> > +	ret =3D mei_wdt_ping(wdt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	wdt->state =3D MEI_WDT_RUNNING;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * mei_wdt_ops_set_timeout - wd set timeout command from the watchdog
> core.
> > + *
> > + * @wdd: watchdog device
> > + * @timeout: timeout value to set
> > + *
> > + * Return: 0 if success, negative errno code for failure
> > + */
> > +static int mei_wdt_ops_set_timeout(struct watchdog_device *wdd,
> > +				   unsigned int timeout)
> > +{
> > +
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +	struct mei_wdt *wdt;
> > +
> > +	if (!mwd)
> > +		return -ENODEV;
> > +
>=20
> And here.
>=20
> > +	wdt =3D mwd->wdt;
> > +
> > +	/* valid value is already checked by the caller */
> > +	wdt->timeout =3D timeout;
> > +	wdd->timeout =3D timeout;
> > +
> > +	return 0;
> > +}
> > +
> > +static void mei_wdt_release(struct kref *ref)
> > +{
> > +	struct mei_wdt_dev *mwd =3D container_of(ref, struct mei_wdt_dev,
> refcnt);
> > +
> > +	kfree(mwd);
> > +}
> > +
> > +static void mei_wdt_ops_ref(struct watchdog_device *wdd)
> > +{
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +
> > +	kref_get(&mwd->refcnt);
> > +}
> > +
> > +static void mei_wdt_ops_unref(struct watchdog_device *wdd)
> > +{
> > +	struct mei_wdt_dev *mwd =3D watchdog_get_drvdata(wdd);
> > +
> > +	kref_put(&mwd->refcnt, mei_wdt_release);
> > +}
> > +
> > +static const struct watchdog_ops wd_ops =3D {
> > +	.owner       =3D THIS_MODULE,
> > +	.start       =3D mei_wdt_ops_start,
> > +	.stop        =3D mei_wdt_ops_stop,
> > +	.ping        =3D mei_wdt_ops_ping,
> > +	.set_timeout =3D mei_wdt_ops_set_timeout,
> > +	.ref         =3D mei_wdt_ops_ref,
> > +	.unref       =3D mei_wdt_ops_unref,
> > +};
> > +
> > +static struct watchdog_info wd_info =3D {
> > +	.identity =3D INTEL_AMT_WATCHDOG_ID,
> > +	.options  =3D WDIOF_KEEPALIVEPING |
> > +		    WDIOF_SETTIMEOUT |
> > +		    WDIOF_ALARMONLY,
> > +};
> > +
> > +/**
> > + * mei_wdt_unregister - unregister from the watchdog subsystem
> > + *
> > + * @wdt: mei watchdog device
> > + */
> > +static void mei_wdt_unregister(struct mei_wdt *wdt)
> > +{
> > +	struct mei_wdt_dev *mwd =3D wdt->mwd;
> > +
> > +	if (!mwd)
> > +		return;
> > +
> And here.
>=20
> > +	watchdog_unregister_device(&mwd->wdd);
> > +	wdt->mwd =3D NULL;
> > +	wdt->state =3D MEI_WDT_IDLE;
> > +	kref_put(&mwd->refcnt, mei_wdt_release);
> > +}
> > +
> > +/**
> > + * mei_wdt_register - register with the watchdog subsystem
> > + *
> > + * @wdt: mei watchdog device
> > + *
> > + * Return: 0 if success, negative errno code for failure
> > + */
> > +static int mei_wdt_register(struct mei_wdt *wdt)
> > +{
> > +	struct mei_wdt_dev *mwd;
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	if (!wdt || !wdt->cldev)
> > +		return -EINVAL;
> > +
> And here.
>=20
> > +	dev =3D &wdt->cldev->dev;
> > +
> > +	mwd =3D kzalloc(sizeof(struct mei_wdt_dev), GFP_KERNEL);
> > +	if (!mwd)
> > +		return -ENOMEM;
> > +
> > +	mwd->wdt =3D wdt;
> > +	mwd->wdd.info =3D &wd_info;
> > +	mwd->wdd.ops =3D &wd_ops;
> > +	mwd->wdd.parent =3D dev;
> > +	mwd->wdd.timeout =3D MEI_WDT_DEFAULT_TIMEOUT;
> > +	mwd->wdd.min_timeout =3D MEI_WDT_MIN_TIMEOUT;
> > +	mwd->wdd.max_timeout =3D MEI_WDT_MAX_TIMEOUT;
> > +	kref_init(&mwd->refcnt);
> > +
> > +	watchdog_set_drvdata(&mwd->wdd, mwd);
> > +	ret =3D watchdog_register_device(&mwd->wdd);
> > +	if (ret) {
> > +		dev_err(dev, "unable to register watchdog device =3D %d.\n", ret);
> > +		kref_put(&mwd->refcnt, mei_wdt_release);
> > +		return ret;
> > +	}
> > +
> > +	wdt->mwd =3D mwd;
> > +	return 0;
> > +}
> > +
> > +static int mei_wdt_probe(struct mei_cl_device *cldev,
> > +			 const struct mei_cl_device_id *id)
> > +{
> > +	struct mei_wdt *wdt;
> > +	int ret;
> > +
> > +	wdt =3D kzalloc(sizeof(struct mei_wdt), GFP_KERNEL);
> > +	if (!wdt)
> > +		return -ENOMEM;
> > +
> > +	wdt->timeout =3D MEI_WDT_DEFAULT_TIMEOUT;
> > +	wdt->state =3D MEI_WDT_IDLE;
> > +	wdt->cldev =3D cldev;
> > +	mei_cldev_set_drvdata(cldev, wdt);
> > +
> > +	ret =3D mei_cldev_enable(cldev);
> > +	if (ret < 0) {
> > +		dev_err(&cldev->dev, "Could not enable cl device\n");
> > +		goto err_out;
> > +	}
> > +
> > +	wd_info.firmware_version =3D mei_cldev_ver(cldev);
> > +
> > +	ret =3D mei_wdt_register(wdt);
> > +	if (ret)
> > +		goto err_disable;
> > +
> > +	return 0;
> > +
> > +err_disable:
> > +	mei_cldev_disable(cldev);
> > +
> > +err_out:
> > +	kfree(wdt);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mei_wdt_remove(struct mei_cl_device *cldev)
> > +{
> > +	struct mei_wdt *wdt =3D mei_cldev_get_drvdata(cldev);
> > +
> > +	mei_wdt_unregister(wdt);
> > +
> > +	mei_cldev_disable(cldev);
> > +
> > +	kfree(wdt);
> > +
> > +	return 0;
> > +}
> > +
> > +#define MEI_UUID_WD UUID_LE(0x05B79A6F, 0x4628, 0x4D7F, \
> > +			    0x89, 0x9D, 0xA9, 0x15, 0x14, 0xCB, 0x32, 0xAB)
> > +
> > +static struct mei_cl_device_id mei_wdt_tbl[] =3D {
> > +	{ .uuid =3D MEI_UUID_WD, .version =3D 0x1},
> > +	/* required last entry */
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(mei, mei_wdt_tbl);
> > +
> > +static struct mei_cl_driver mei_wdt_driver =3D {
> > +	.id_table =3D mei_wdt_tbl,
> > +	.name =3D KBUILD_MODNAME,
> > +
> > +	.probe =3D mei_wdt_probe,
> > +	.remove =3D mei_wdt_remove,
> > +};
> > +
> > +static int __init mei_wdt_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret =3D mei_cldev_driver_register(&mei_wdt_driver);
> > +	if (ret) {
> > +		pr_err(KBUILD_MODNAME ": module registration failed\n");
> > +		return ret;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void __exit mei_wdt_exit(void)
> > +{
> > +	mei_cldev_driver_unregister(&mei_wdt_driver);
> > +}
> > +
> > +module_init(mei_wdt_init);
> > +module_exit(mei_wdt_exit);
> > +
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Device driver for Intel MEI iAMT watchdog");
> >
