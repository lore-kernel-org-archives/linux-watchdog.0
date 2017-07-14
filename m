Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:44280 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdGNIgN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 04:36:13 -0400
Subject: Re: [PATCH 5/5 v4] watchdog: sp5100_tco: Use
 request_declared_muxed_region()
To: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>,
        Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net,
        wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com,
        cshorler@googlemail.com, wsa@the-dreams.de,
        regressions@leemhuis.info,
        Alex Williamson <alex.williamson@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Jakub Sitnicki <jsitnicki@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Travis <travis@sgi.com>,
        Daeseok Youn <daeseok.youn@gmail.com>,
        Huang Rui <ray.huang@amd.com>, Andiry Xu <andiry.xu@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        David Howells <dhowells@redhat.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Alexandre Desnoyers <alex@qtec.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wan ZongShun <Vincent.Wan@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <dev@lynxeye.de>,
        Denis Turischev <denis.turischev@compulab.co.il>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-6-zboszor@pr.hu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <343c2024-78c9-4093-06b1-f017fe8d9043@pr.hu>
Date: Fri, 14 Jul 2017 10:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170622132134.7200-6-zboszor@pr.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2017-06-22 15:21 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi=
 =C3=ADrta:
> Use the new request_declared_muxed_region() macro to synchronize
> accesses to the SB800 I/O port pair (0xcd6 / 0xcd7) with the
> PCI quirk for isochronous USB transfers and with the i2c-piix4
> driver.
>=20
> At the same time, remove the long lifetime request_region() call
> to reserve these I/O ports, similarly to i2c-piix4 so the code is
> now uniform across the three drivers.
>=20
> v1: Started with a common mutex in a C source file.
>=20
> v2: Referenced the common mutex from drivers/usb/host/pci-quirks.c
>=20
> v3: Switched to using the new request_declared_muxed_region
>      macro.
>=20
> v4: Fixed checkpatch.pl warnings and use the new
>      release_declared_region() macro.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
> ---
>   drivers/watchdog/sp5100_tco.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tc=
o.c
> index 028618c..cb42b72 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -48,7 +48,6 @@
>   static u32 tcobase_phys;
>   static u32 tco_wdt_fired;
>   static void __iomem *tcobase;
> -static unsigned int pm_iobase;
>   static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
>   static unsigned long timer_alive;
>   static char tco_expect_close;
> @@ -70,6 +69,11 @@ module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
>   		" (default=3D" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  =20
> +/* synchronized access to the I/O port pair */
> +static struct resource sp5100_res =3D DEFINE_RES_IO_NAMED(SB800_IO_PM_=
INDEX_REG,
> +						SP5100_PM_IOPORTS_SIZE,
> +						TCO_MODULE_NAME);
> +
>   /*
>    * Some TCO specific functions
>    */
> @@ -139,6 +143,7 @@ static void tco_timer_enable(void)
>   	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
>   		/* For SB800 or later */
>   		/* Set the Watchdog timer resolution to 1 sec */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
>   		val =3D inb(SB800_IO_PM_DATA_REG);
>   		val |=3D SB800_PM_WATCHDOG_SECOND_RES;
> @@ -150,6 +155,7 @@ static void tco_timer_enable(void)
>   		val |=3D SB800_PCI_WATCHDOG_DECODE_EN;
>   		val &=3D ~SB800_PM_WATCHDOG_DISABLE;
>   		outb(val, SB800_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	} else {
>   		/* For SP5100 or SB7x0 */
>   		/* Enable watchdog decode bit */
> @@ -164,11 +170,13 @@ static void tco_timer_enable(void)
>   				       val);
>  =20
>   		/* Enable Watchdog timer and set the resolution to 1 sec */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
>   		val =3D inb(SP5100_IO_PM_DATA_REG);
>   		val |=3D SP5100_PM_WATCHDOG_SECOND_RES;
>   		val &=3D ~SP5100_PM_WATCHDOG_DISABLE;
>   		outb(val, SP5100_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	}
>   }
>  =20
> @@ -361,16 +369,10 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		base_addr =3D SB800_PM_WATCHDOG_BASE;
>   	}
>  =20
> -	/* Request the IO ports used by this driver */
> -	pm_iobase =3D SP5100_IO_PM_INDEX_REG;
> -	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE, dev_name)) {
> -		pr_err("I/O address 0x%04x already in use\n", pm_iobase);
> -		goto exit;
> -	}
> -
>   	/*
>   	 * First, Find the watchdog timer MMIO address from indirect I/O.
>   	 */
> +	request_declared_muxed_region(&sp5100_res);
>   	outb(base_addr+3, index_reg);
>   	val =3D inb(data_reg);
>   	outb(base_addr+2, index_reg);
> @@ -380,6 +382,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   	outb(base_addr+0, index_reg);
>   	/* Low three bits of BASE are reserved */
>   	val =3D val << 8 | (inb(data_reg) & 0xf8);
> +	release_declared_region(&sp5100_res);
>  =20
>   	pr_debug("Got 0x%04x from indirect I/O\n", val);
>  =20
> @@ -400,6 +403,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
>   	} else {
>   		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
> +		request_declared_muxed_region(&sp5100_res);
>   		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
>   		val =3D inb(SB800_IO_PM_DATA_REG);
>   		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
> @@ -408,6 +412,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		val =3D val << 8 | inb(SB800_IO_PM_DATA_REG);
>   		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
>   		val =3D val << 8 | inb(SB800_IO_PM_DATA_REG);
> +		release_declared_region(&sp5100_res);
>   	}
>  =20
>   	/* The SBResource_MMIO is enabled and mapped memory space? */
> @@ -429,7 +434,7 @@ static unsigned char sp5100_tco_setupdevice(void)
>   		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
>  =20
>   	pr_notice("failed to find MMIO address, giving up.\n");
> -	goto  unreg_region;
> +	goto  exit;
>  =20
>   setup_wdt:
>   	tcobase_phys =3D val;
> @@ -469,8 +474,6 @@ static unsigned char sp5100_tco_setupdevice(void)
>  =20
>   unreg_mem_region:
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -unreg_region:
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>   exit:
>   	return 0;
>   }
> @@ -517,7 +520,7 @@ static int sp5100_tco_init(struct platform_device *=
dev)
>   exit:
>   	iounmap(tcobase);
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
> +	release_region(SB800_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
>   	return ret;
>   }
>  =20
> @@ -531,7 +534,6 @@ static void sp5100_tco_cleanup(void)
>   	misc_deregister(&sp5100_tco_miscdev);
>   	iounmap(tcobase);
>   	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
> -	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
>   }
>  =20
>   static int sp5100_tco_remove(struct platform_device *dev)
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
