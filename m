Return-Path: <SRS0=sDHB=QO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01CC282C2
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC1B21721
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="JfQQzopj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBGVD6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:03:58 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:5189
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfBGVD6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Feb 2019 16:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aFGlIuvToNJLlIX9uQo8e4rf9BH0467nOoLUzIortI=;
 b=JfQQzopj0o4eJOsUhV748ybBs8uNm824fjXVOeRo1Wj3uKKldeAT1fe8WUkaxxIIxY++HaZqWu98pyJowgh3wBgwPlFoXGTh6g30F7SOh5G9R8hl0HrpQo1+sjAMtzos5kETY6VxXkJ6EUJQg8Q23QJZ8slMFr9QTVHKgMKtqHo=
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com (20.178.94.209) by
 AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.36.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 21:03:40 +0000
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b]) by AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b%3]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 21:03:40 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH v1 2/3] watchdog: mlx-wdt: introduce watchdog driver for
 Mellanox systems.
Thread-Topic: [PATCH v1 2/3] watchdog: mlx-wdt: introduce watchdog driver for
 Mellanox systems.
Thread-Index: AQHUvjwlj75VK9orykyIvDpzpSCPl6XTI8qAgAFWHcA=
Date:   Thu, 7 Feb 2019 21:03:40 +0000
Message-ID: <AM6PR05MB616876A5F07934BF5AEC4D20D9680@AM6PR05MB6168.eurprd05.prod.outlook.com>
References: <20190206165037.4346-1-michaelsh@mellanox.com>
 <20190206165037.4346-3-michaelsh@mellanox.com>
 <20190206191407.GA12477@roeck-us.net>
In-Reply-To: <20190206191407.GA12477@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB4968;6:BYzi6rkBT0p4hEOk7T8fivjr++gFl9Ci0ijdebfExraiG463Z5FZL0qZHrTNEVOO5VQY4wsDDyBEC2dkyTbsjVKjLwZB6lZ239TlSe31rXmvDm10mack+oSOiTtUbCrd7I5dR36VHd955bIU40I2tE25lzkaGJBC6kQ6PuQEO6wALCtuH8JRvNrUun9QZbKIOCVNmBTP3sclijGk+/8KWTMoYC5Be62Hkiv7J+9pTHy2cFEfbpPgLeqWO6i/mPnWCNmrW4YIXY29rbBgD6R0YQTWuwvjB+yp0mSRN0UAfAE+AMUteyFkhTQ7QS857x+hm4ftANBDtTvsn73Vl5go9IoEBn5ZNMGKrQNdunpfRF7jduMOShHAwLfo9n4QLXR2kBEUOsRgAOb8yYWZCou6aCebYjp2ELTNP2dLc8kr9d9dhdCa6gEJqNUdwz29qoVsLexobx/E9kMWg2L95Ji1QQ==;5:T88hH95kCLFGvCesauyAK6khZvabhB+ecMZGT9eScIP+JAc6B6ZdgrHmxzI67/NOEBgsr3fC0IlCIBZOrXZxYuLSkpKGhxUfviQPinwnTd0YBEG/vjZxUgT1v/b+1/XBGtdoV90L/nEllF9P72RDJ9OGwrJTBwBP3xe5RDzYFk+aR4D7EO9CCgQDg6zgXcqO6g+Ez4fDb/m0AbqqcWYJkw==;7:2J7fuOqfvbgoM+GmeqiKJjXxv1v1UlrY6Kq4B0jcZ++6xn+psZ0JO8ewdECmn3yJPd70pMCAFbNo31yjncCORTNl2bkR+SekrCC20ITo0yhYw6muZ/+1cK+C/5/MWp+MrgXLb/KhNnyn7wyG9TpeVw==
x-ms-office365-filtering-correlation-id: b1e86146-5d6a-4f1c-f788-08d68d3fbc90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4968;
x-ms-traffictypediagnostic: AM6PR05MB4968:
x-microsoft-antispam-prvs: <AM6PR05MB4968B16ED848A48579413307D9680@AM6PR05MB4968.eurprd05.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(13464003)(478600001)(74316002)(486006)(256004)(446003)(55016002)(11346002)(14454004)(33656002)(186003)(25786009)(6916009)(229853002)(14444005)(6436002)(2906002)(476003)(97736004)(81156014)(107886003)(4326008)(71200400001)(99286004)(6506007)(7736002)(7696005)(8676002)(102836004)(81166006)(53546011)(3846002)(8936002)(26005)(71190400001)(54906003)(86362001)(305945005)(105586002)(316002)(106356001)(53946003)(9686003)(53936002)(68736007)(66066001)(6246003)(30864003)(6116002)(76176011)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4968;H:AM6PR05MB6168.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9egmeNGdyQlB2xb2Jrak2zy/2yS14FrHgYY+Jg9GBtQBlGYPM1Zn9ZmM+qdW3kovCG/Kqp1dmnm71xI5OADSaqvI79Zyu2r6O9WAHMRAbnPLvHE2DJalDViLt6AflWqcKb/dxsTIbllXbDUaCWFoE3jwRDJI+Yl5pPzHhUy7tiiDczr8V1ZZ5tS3B2MvG5d3IJUiLTfCPDq4QY4Mcfkq4e80aN9N2mpPgrp99EMwAvJEdjjZfoAd4hDQ9WOQI+FNBeyPBLIf4kQ/Onc8wsx5P8EJQ/cKkjlqW8mU7sPGNCQGdwNIhMXhXgaDLBBRk5Dqh9NVUzsNKW8yEvc6g/a6CLtgKTSbFNqM2po/MD3HK2OJwlHUCMK7QTwxH1X//pOplSxRAwdFI/UNIWarNgb7uGmKMP7JBlE3n3I1xaYblqE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e86146-5d6a-4f1c-f788-08d68d3fbc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 21:03:40.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4968
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Guenter,

Thank you for your prompt review and comments.

Regards,
    Michael.

> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> Sent: Wednesday, February 6, 2019 9:14 PM
> To: Michael Shych <michaelsh@mellanox.com>
> Cc: wim@linux-watchdog.org; andy@infradead.org; dvhart@infradead.org;
> linux-watchdog@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Vadim Pasternak <vadimp@mellanox.com>
> Subject: Re: [PATCH v1 2/3] watchdog: mlx-wdt: introduce watchdog driver
> for Mellanox systems.
>=20
> On Wed, Feb 06, 2019 at 04:50:36PM +0000, michaelsh@mellanox.com
> wrote:
> > From: Michael Shych <michaelsh@mellanox.com>
> >
> > Introduce watchdog driver for variious rang of Mellanox Ethernet and
>=20
> s/variious/various/
>=20
> > Infiniband switch systems.
> >
> > Watchdog driver for Mellanox watchdog devices, implemented in
> > programmable logic device.
> >
> > Main and auxiliary watchdog devices can exist on the same system.
> > There are several actions that can be defined in the watchdog:
> > system reset, start fans on full speed and increase a counter.
> > The last 2 actions are performed without a system reset.
> > Actions without reset are provided for auxiliary watchdog devices,
> > which is optional.
> > Access to HW registers is performed through generic
> > regmap interface.
> >
> > There are 2 types of HW watchdog implementations.
> > Type 1: actual HW timeout can be defined as power of 2 msec.
> > e.g. timeout 20 sec will be rounded up to 32768 msec.;
> > maximum timeout period is 32 sec (32768 msec.);
> > get time-left isn't supported
> > Type 2: actual HW timeout is defined in sec. and it's the same as
> > user-defined timeout;
> > maximum timeout is 255 sec;
> > get time-left is supported;
> >
> > Watchdog driver is probed from the common mlx_platform driver.
> >
> > Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> > ---
> >  drivers/watchdog/Kconfig   |  16 ++
> >  drivers/watchdog/Makefile  |   1 +
> >  drivers/watchdog/mlx_wdt.c | 406
> +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 423 insertions(+)
> >  create mode 100644 drivers/watchdog/mlx_wdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 57f017d74a97..f1766eb081bb 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -241,6 +241,22 @@ config RAVE_SP_WATCHDOG
> >  	help
> >  	  Support for the watchdog on RAVE SP device.
> >
> > +config MLX_WDT
> > +	tristate "Mellanox Watchdog"
> > +	depends on MELLANOX_PLATFORM
> > +	select WATCHDOG_CORE
> > +	select REGMAP
> > +	help
> > +	  This is the driver for the hardware watchdog on Mellanox systems.
> > +	  If you are going to use it, say Y here, otherwise N.
> > +	  This driver can be used together with the watchdog daemon.
> > +	  It can also watch your kernel to make sure it doesn't freeze,
> > +	  and if it does, it reboots your system after a certain amount of
> > +	  time.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called mlx-wdt.
> > +
> >  # ALPHA Architecture
> >
> >  # ARM Architecture
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index a0917ef28e07..941b74185c9c 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -142,6 +142,7 @@ obj-$(CONFIG_INTEL_MID_WATCHDOG) +=3D intel-
> mid_wdt.o
> >  obj-$(CONFIG_INTEL_MEI_WDT) +=3D mei_wdt.o
> >  obj-$(CONFIG_NI903X_WDT) +=3D ni903x_wdt.o
> >  obj-$(CONFIG_NIC7018_WDT) +=3D nic7018_wdt.o
> > +obj-$(CONFIG_MLX_WDT) +=3D mlx_wdt.o
> >
> >  # M68K Architecture
> >  obj-$(CONFIG_M54xx_WATCHDOG) +=3D m54xx_wdt.o
> > diff --git a/drivers/watchdog/mlx_wdt.c b/drivers/watchdog/mlx_wdt.c
> > new file mode 100644
> > index 000000000000..be28aa165cf2
> > --- /dev/null
> > +++ b/drivers/watchdog/mlx_wdt.c
> > @@ -0,0 +1,406 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Mellanox watchdog driver
> > + *
> > + * Copyright (C) 2019 Mellanox Technologies
> > + * Copyright (C) 2019 Michael Shych <mshych@mellanox.com>
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_data/mlxreg.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +#include <linux/watchdog.h>
> > +
> > +#define MLXREG_WDT_CLOCK_SCALE		1000
> > +#define MLXREG_WDT_MAX_TIMEOUT_TYPE1	32
> > +#define MLXREG_WDT_MAX_TIMEOUT_TYPE2	255
> > +#define MLXREG_WDT_MIN_TIMEOUT		1
> > +#define MLXREG_WDT_HW_TIMEOUT_CONVERT(hw_timeout) ((1 <<
> (hw_timeout)) \
> > +						   /
> MLXREG_WDT_CLOCK_SCALE)
> > +#define MLXREG_WDT_OPTIONS_BASE (WDIOF_KEEPALIVEPING |
> WDIOF_MAGICCLOSE | \
> > +				 WDIOF_SETTIMEOUT)
> > +
> > +/**
> > + * enum mlxreg_wdt_type - type of HW watchdog
> > + *
> > + * TYPE1 can be differentiated by different register/mask
> > + *	 for WD action set and ping.
> > + */
> > +enum mlxreg_wdt_type {
> > +	MLX_WDT_TYPE1,
> > +	MLX_WDT_TYPE2,
> > +};
> > +
> > +/**
> > + * struct mlxreg_wdt - wd private data:
> > + *
> > + * @wdd:	watchdog device;
> > + * @device:	basic device;
> > + * @pdata:	data received from platform driver;
> > + * @regmap:	register map of parent device;
> > + * @timeout:	defined timeout in sec.;
> > + * @hw_timeout:	real timeout set in hw;
> > + *		It will be roundup base of 2 in WD type 1,
> > + *		in WD type 2 it will be same number of sec as timeout;
> > + * @action_idx:	index for direct access to action register;
> > + * @timeout_idx:index for direct access to TO register;
> > + * @tleft_idx:	index for direct access to time left register;
> > + * @ping_idx:	index for direct access to ping register;
> > + * @reset_idx:	index for direct access to reset cause register;
> > + * @wd_type:	watchdog HW type;
> > + * @hw_timeout:	actual HW timeout;
> > + * @io_lock:	spinlock for io access;
>=20
> watchdog device access is already synchromized in the watchdog core.
> Why is this additional lock needed ?

Removed it.
>=20
> > + */
> > +struct mlxreg_wdt {
> > +	struct watchdog_device wdd;
> > +	struct mlxreg_core_platform_data *pdata;
> > +	void *regmap;
> > +	int action_idx;
> > +	int timeout_idx;
> > +	int tleft_idx;
> > +	int ping_idx;
> > +	int reset_idx;
> > +	enum mlxreg_wdt_type wdt_type;
> > +	u8 hw_timeout;
> > +	spinlock_t io_lock;	/* the lock for io operations */
> > +};
> > +
> > +static int mlxreg_wdt_roundup_to_base_2(struct mlxreg_wdt *wdt, int
> timeout)
> > +{
> > +	timeout *=3D MLXREG_WDT_CLOCK_SCALE;
> > +
> > +	wdt->hw_timeout =3D order_base_2(timeout);
> > +	dev_info(wdt->wdd.parent,
> > +		 "watchdog %s timeout %d was rounded up to %lu
> (msec)\n",
> > +		 wdt->wdd.info->identity, timeout,
> roundup_pow_of_two(timeout));
>=20
> Please no noise here. It is quite common for watchdog drivers to
> set a timeout value not exactly matching the real timeout.
> That is why the selected value is reported to userspace.
>=20
> > +
> > +	return 0;
>=20
> What exactly is the point of this return value ?

Just made as in other watchdog examples.
Changed function to void.
>=20
> > +}
> > +
> > +static enum mlxreg_wdt_type
> > +mlxreg_wdt_check_watchdog_type(struct mlxreg_wdt *wdt,
> > +			       struct mlxreg_core_platform_data *pdata)
> > +{
> > +	if (pdata->data[wdt->action_idx].reg =3D=3D
> > +	    pdata->data[wdt->ping_idx].reg &&
> > +	    pdata->data[wdt->action_idx].mask =3D=3D
> > +	    pdata->data[wdt->ping_idx].mask)
> > +		return MLX_WDT_TYPE2;
> > +
> > +	return MLX_WDT_TYPE1;
> > +}
> > +
> > +static int mlxreg_wdt_check_card_reset(struct mlxreg_wdt *wdt)
> > +{
> > +	struct mlxreg_core_data *reg_data;
> > +	u32 regval;
> > +	int rc;
> > +
> > +	if (wdt->reset_idx =3D=3D -EINVAL)
> > +		return -EINVAL;
> > +
> Return values from this function are not checked and are
> thus pointless.

Changed function to void.
>=20
> > +	if (!(wdt->wdd.info->options & WDIOF_CARDRESET))
> > +		return 0;
> > +
> > +	spin_lock(&wdt->io_lock);
> > +	reg_data =3D &wdt->pdata->data[wdt->reset_idx];
> > +	rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +	spin_unlock(&wdt->io_lock);
> > +	if (rc)
> > +		goto read_error;
> > +
> > +	if (regval & ~reg_data->mask) {
> > +		wdt->wdd.bootstatus =3D WDIOF_CARDRESET;
> > +		dev_info(wdt->wdd.parent,
> > +			 "watchdog previously reset the CPU\n");
> > +	}
> > +
> > +read_error:
> > +	return rc;
> > +}
> > +
> > +static int mlxreg_wdt_start(struct watchdog_device *wdd)
> > +{
> > +	struct mlxreg_wdt *wdt =3D watchdog_get_drvdata(wdd);
> > +	struct mlxreg_core_data *reg_data =3D &wdt->pdata->data[wdt-
> >action_idx];
> > +	u32 regval;
> > +	int rc;
> > +
> > +	spin_lock(&wdt->io_lock);
> > +	rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +	if (rc) {
> > +		spin_unlock(&wdt->io_lock);
> > +		goto read_error;
> > +	}
> > +
> > +	regval =3D (regval & reg_data->mask) | BIT(reg_data->bit);
> > +	rc =3D regmap_write(wdt->regmap, reg_data->reg, regval);
>=20
> I don't immediately see why regmap_update_bits() would not work here.

Replaced it to regmap_update_bits()
>=20
> > +	spin_unlock(&wdt->io_lock);
> > +	if (!rc) {
> > +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>=20
> Setting WDOG_HW_RUNNING is only necessary if set during probe,
> or in the stop function if the watchdog can not be stopped.
> It should not be necessary here.
>=20
> [ I see you are calling this function from probe.
>   Set the bit there. ]

Moved to probe.
>=20
> > +		dev_info(wdd->parent, "watchdog %s started\n",
> > +			 wdd->info->identity);
>=20
> Is all this noise really necessary ?

Removed it.
>=20
> > +	}
> > +
> > +read_error:
> > +	return rc;
> > +}
> > +
> > +static int mlxreg_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct mlxreg_wdt *wdt =3D watchdog_get_drvdata(wdd);
> > +	struct mlxreg_core_data *reg_data =3D &wdt->pdata->data[wdt-
> >action_idx];
> > +	u32 regval;
> > +	int rc;
> > +
> > +	spin_lock(&wdt->io_lock);
> > +	rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +	if (rc) {
> > +		spin_unlock(&wdt->io_lock);
> > +		goto read_error;
> > +	}
> > +
> > +	regval =3D (regval & reg_data->mask) & ~BIT(reg_data->bit);
> > +	rc =3D regmap_write(wdt->regmap, reg_data->reg, regval);
>=20
> I don't immediately see why regmap_update_bits() would not work here.

Replaced it to regmap_update_bits()
>=20
> > +	spin_unlock(&wdt->io_lock);
> > +	if (!rc)
> > +		dev_info(wdd->parent, "watchdog %s stopped\n",
> > +			 wdd->info->identity);
> > +
> > +read_error:
> > +	return rc;
> > +}
> > +
> > +static int mlxreg_wdt_ping(struct watchdog_device *wdd)
> > +{
> > +	struct mlxreg_wdt *wdt =3D watchdog_get_drvdata(wdd);
> > +	struct mlxreg_core_data *reg_data =3D &wdt->pdata->data[wdt-
> >ping_idx];
> > +	u32 regval;
> > +	int rc;
> > +
> > +	spin_lock(&wdt->io_lock);
> > +	rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +	if (rc)
> > +		goto read_error;
> > +
> > +	regval =3D (regval & reg_data->mask) | BIT(reg_data->bit);
> > +	rc =3D regmap_write(wdt->regmap, reg_data->reg, regval);
>=20
> Same as above. Besides, the only difference to the start function is the
> logging noise there. I would suggest to drop the noise as well as this
> function.
>=20

Different register is used in ping and start.
Removed unneeded log.
Replaced to regmap_update_bits_base(), because this bit should be
always refreshed in HW, i.e. perform force update.
> > +
> > +read_error:
> > +	spin_unlock(&wdt->io_lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static int mlxreg_wdt_set_timeout(struct watchdog_device *wdd,
> > +				  unsigned int timeout)
> > +{
> > +	struct mlxreg_wdt *wdt =3D watchdog_get_drvdata(wdd);
> > +	struct mlxreg_core_data *reg_data =3D &wdt->pdata->data[wdt-
> >timeout_idx];
> > +	u32 regval, set_time;
> > +	int rc;
> > +
> > +	spin_lock(&wdt->io_lock);
> > +
> > +	if (wdt->wdt_type =3D=3D MLX_WDT_TYPE1) {
> > +		rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +		if (rc)
> > +			goto read_error;
> > +		mlxreg_wdt_roundup_to_base_2(wdt, timeout);
> > +		regval =3D (regval & reg_data->mask) | wdt->hw_timeout;
> > +		/* Rowndown to actual closest number of sec. */
> > +		set_time =3D MLXREG_WDT_HW_TIMEOUT_CONVERT(wdt-
> >hw_timeout);
>=20
> The code is expected to set the value of "wdd->timeout" to the actual
> timeout. This is why it is set here, and not in the calling code.

Moved it to this function.
>=20
> > +	} else {
> > +		wdt->hw_timeout =3D timeout;
> > +		set_time =3D timeout;
> > +		regval =3D timeout;
> > +	}
> > +
> > +	watchdog_init_timeout(&wdt->wdd, set_time, wdd->parent);
>=20
> This is wrong here. Just set wdd->timeout. watchdog_init_timeout()
> should only be called in the probe function.

Set directly wdd->timeout
>=20
> > +	rc =3D regmap_write(wdt->regmap, reg_data->reg, regval);
> > +
> > +read_error:
> > +	spin_unlock(&wdt->io_lock);
> > +	if (!rc) {
> > +		if (watchdog_active(wdd)) {
>=20
> This warrants an explanation: Presumably updating the timeout
> requires it to be stopped and restarted. Overall, however,
> it would probably be simpler to call regmap_update_bits()
> twice directly here.

Added comments.
>=20
> > +			rc =3D mlxreg_wdt_stop(wdd);
> > +			if (!rc)
> > +				rc =3D mlxreg_wdt_start(wdd);
> > +		}
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static unsigned int mlxreg_wdt_get_timeleft(struct watchdog_device
> *wdd)
> > +{
> > +	struct mlxreg_wdt *wdt =3D watchdog_get_drvdata(wdd);
> > +	struct mlxreg_core_data *reg_data =3D &wdt->pdata->data[wdt-
> >tleft_idx];
> > +	u32 regval;
> > +	int rc;
> > +
> > +	if (wdt->wdt_type =3D=3D MLX_WDT_TYPE1)
> > +		return 0;
> > +
> Should never get here, thus this check is unnecessary.
>=20

Removed it.
> > +	spin_lock(&wdt->io_lock);
> > +	rc =3D regmap_read(wdt->regmap, reg_data->reg, &regval);
> > +	spin_unlock(&wdt->io_lock);
> > +
> > +	return rc =3D=3D 0 ? regval : 0;
> > +}
> > +
> > +static const struct watchdog_ops mlxreg_wdt_ops_type1 =3D {
> > +	.start		=3D mlxreg_wdt_start,
> > +	.stop		=3D mlxreg_wdt_stop,
> > +	.ping		=3D mlxreg_wdt_ping,
> > +	.set_timeout	=3D mlxreg_wdt_set_timeout,
> > +	.owner		=3D THIS_MODULE,
> > +};
> > +
> > +static const struct watchdog_ops mlxreg_wdt_ops_type2 =3D {
> > +	.start		=3D mlxreg_wdt_start,
> > +	.stop		=3D mlxreg_wdt_stop,
> > +	.ping		=3D mlxreg_wdt_ping,
> > +	.set_timeout	=3D mlxreg_wdt_set_timeout,
> > +	.get_timeleft	=3D mlxreg_wdt_get_timeleft,
> > +	.owner		=3D THIS_MODULE,
> > +};
> > +
> > +static const struct watchdog_info mlxreg_wdt_main_info =3D {
> > +	.options	=3D MLXREG_WDT_OPTIONS_BASE
> > +			| WDIOF_CARDRESET,
> > +	.identity	=3D "mlx-wdt-main",
> > +};
> > +
> > +static const struct watchdog_info mlxreg_wdt_aux_info =3D {
> > +	.options	=3D MLXREG_WDT_OPTIONS_BASE
> > +			| WDIOF_ALARMONLY,
> > +	.identity	=3D "mlx-wdt-aux",
> > +};
> > +
> > +static int mlxreg_wdt_config(struct mlxreg_wdt *wdt,
> > +			     struct mlxreg_core_platform_data *pdata)
> > +{
> > +	struct mlxreg_core_data *data =3D pdata->data;
> > +	int i;
> > +
> > +	wdt->reset_idx =3D -EINVAL;
> > +	for (i =3D 0; i < pdata->counter; i++, data++) {
> > +		if (strnstr(data->label, "action", sizeof(data->label)))
> > +			wdt->action_idx =3D i;
> > +		else if (strnstr(data->label, "timeout", sizeof(data->label)))
> > +			wdt->timeout_idx =3D i;
> > +		else if (strnstr(data->label, "timeleft", sizeof(data->label)))
> > +			wdt->tleft_idx =3D i;
> > +		else if (strnstr(data->label, "ping", sizeof(data->label)))
> > +			wdt->ping_idx =3D i;
> > +		else if (strnstr(data->label, "reset", sizeof(data->label)))
> > +			wdt->reset_idx =3D i;
> > +	}
> > +
> > +	wdt->pdata =3D pdata;
> > +	if (strnstr(pdata->identity, mlxreg_wdt_main_info.identity,
> > +		    sizeof(mlxreg_wdt_main_info.identity)))
> > +		wdt->wdd.info =3D &mlxreg_wdt_main_info;
> > +	else
> > +		wdt->wdd.info =3D &mlxreg_wdt_aux_info;
> > +
> > +	wdt->wdt_type =3D mlxreg_wdt_check_watchdog_type(wdt, pdata);
> > +	if (wdt->wdt_type =3D=3D MLX_WDT_TYPE2) {
> > +		wdt->wdd.ops =3D &mlxreg_wdt_ops_type2;
> > +		wdt->wdd.max_timeout =3D
> MLXREG_WDT_MAX_TIMEOUT_TYPE2;
> > +	} else {
> > +		wdt->wdd.ops =3D &mlxreg_wdt_ops_type1;
> > +		wdt->wdd.max_timeout =3D
> MLXREG_WDT_MAX_TIMEOUT_TYPE1;
> > +	}
> > +	wdt->wdd.min_timeout =3D MLXREG_WDT_MIN_TIMEOUT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mlxreg_wdt_init_timeout(struct mlxreg_wdt *wdt,
> > +				   struct mlxreg_core_platform_data *pdata)
> > +{
> > +	u32 timeout;
> > +
> > +	timeout =3D pdata->data[wdt->timeout_idx].health_cntr;
> > +	return mlxreg_wdt_set_timeout(&wdt->wdd, timeout);
> > +}
> > +
> > +static int mlxreg_wdt_probe(struct platform_device *pdev)
> > +{
> > +	struct mlxreg_core_platform_data *pdata;
> > +	struct mlxreg_wdt *wdt;
> > +	int rc;
> > +
> > +	pdata =3D dev_get_platdata(&pdev->dev);
> > +	if (!pdata) {
> > +		dev_err(&pdev->dev, "Failed to get platform data.\n");
> > +		return -EINVAL;
> > +	}
> > +	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +	if (!wdt)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&wdt->io_lock);
> > +
> > +	wdt->wdd.parent =3D &pdev->dev;
> > +	wdt->regmap =3D pdata->regmap;
> > +	mlxreg_wdt_config(wdt, pdata);
> > +
> > +	if ((pdata->features &
> MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START))
> > +		watchdog_set_nowayout(&wdt->wdd,
> WATCHDOG_NOWAYOUT);
>=20
> That is a bit different than the requested functionality, isn't it ?
>

Changed name MLXREG_CORE_WD_FEATURE_NOSTOP_AFTER_START to
MLXREG_CORE_WD_FEATURE_NOWAYOUT.
WDOG_NO_WAY_OUT	bit will be set if it's provided by platform and
Also CONFIG_WATCHDOG_NOWAYOUT is set.
=20
> > +	watchdog_stop_on_reboot(&wdt->wdd);
> > +	watchdog_set_drvdata(&wdt->wdd, wdt);
> > +	mlxreg_wdt_check_card_reset(wdt);
> > +	rc =3D mlxreg_wdt_init_timeout(wdt, pdata);
> > +	if (rc) {
> > +		dev_err(&pdev->dev,
> > +			"Cannot init watchdog timeout (err=3D%d)\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	rc =3D devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> > +	if (rc) {
> > +		dev_err(&pdev->dev,
> > +			"Cannot register watchdog device (err=3D%d)\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	if ((pdata->features &
> MLXREG_CORE_WD_FEATURE_START_AT_BOOT))
> > +		mlxreg_wdt_start(&wdt->wdd);
>=20
> This should be called before registering the watchdog, and
> WDOG_HW_RUNNING
> should be set here to let the core know that the watchdog is running.

Moved it and changed set of WDOG_HW_RUNNING
>=20
> > +
> > +	return rc;
>=20
> rc is always 0 here.
>=20
> > +}
> > +
> > +static int mlxreg_wdt_remove(struct platform_device *pdev)
> > +{
> > +	struct mlxreg_wdt *wdt =3D dev_get_platdata(&pdev->dev);
> > +
> > +	mlxreg_wdt_stop(&wdt->wdd);
>=20
> Call watchdog_stop_on_unregister() before registering the watchdog.
>=20
> > +	watchdog_unregister_device(&wdt->wdd);
>=20
> This is wrong. The watchdog is registered with a devm_ function
> and is thus automatically unregistered.
>=20

Removed it.
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mlxreg_wdt_driver =3D {
> > +	.probe	=3D mlxreg_wdt_probe,
> > +	.remove	=3D mlxreg_wdt_remove,
> > +	.driver	=3D {
> > +			.name =3D "mlx-wdt",
> > +	},
> > +};
> > +
> > +module_platform_driver(mlxreg_wdt_driver);
> > +
> > +MODULE_AUTHOR("Michael Shych <michaelsh@mellanox.com>");
> > +MODULE_DESCRIPTION("Mellanox watchdog driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:mlx-wdt");
> > --
> > 2.11.0
> >
