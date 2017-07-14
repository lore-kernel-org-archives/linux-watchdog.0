Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:58988 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbdGNIfX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 04:35:23 -0400
Subject: Re: [PATCH 3/5 v4] usb: pci-quirks: Protect the I/O port pair of
 SB800
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
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-4-zboszor@pr.hu>
From: Boszormenyi Zoltan <zboszor@pr.hu>
Message-ID: <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
Date: Fri, 14 Jul 2017 10:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170622132134.7200-4-zboszor@pr.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2017-06-22 15:21 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi=
 =C3=ADrta:
> This patch uses the previously introduced macro called
> request_declared_muxed_region() to synchronize access to
> the I/O port pair 0xcd6 / 0xcd7 on SB800.
>=20
> These I/O ports are also used by i2c-piix4 and sp5100_tco,
> so synchronization is necessary. The other drivers will also
> be modified to use the new macro in subsequest patched.
>=20
> v1: Started with a common mutex in a C source file.
>=20
> v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
>      instead of in a common C file.
>=20
> v3: Switched to using the new request_declared_muxed_region
>      macro.
>=20
> v4: Fixed checkpatch.pl warnings and use the new
>      release_declared_region() macro.
>=20
> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
> ---
>   drivers/usb/host/pci-quirks.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirk=
s.c
> index a9a1e4c..593942a 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -279,6 +279,8 @@ bool usb_amd_prefetch_quirk(void)
>   }
>   EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
>  =20
> +static struct resource sb800_res =3D DEFINE_RES_IO_NAMED(0xcd6, 2, "SB=
800 USB");
> +
>   /*
>    * The hardware normally enables the A-link power management feature,=
 which
>    * lets the system lower the power consumption in idle states.
> @@ -314,11 +316,13 @@ static void usb_amd_quirk_pll(int disable)
>   	if (amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_SB800 ||
>   			amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_HUDSON2 ||
>   			amd_chipset.sb_type.gen =3D=3D AMD_CHIPSET_BOLTON) {
> +		request_declared_muxed_region(&sb800_res);
>   		outb_p(AB_REG_BAR_LOW, 0xcd6);
>   		addr_low =3D inb_p(0xcd7);
>   		outb_p(AB_REG_BAR_HIGH, 0xcd6);
>   		addr_high =3D inb_p(0xcd7);
>   		addr =3D addr_high << 8 | addr_low;
> +		release_declared_region(&sb800_res);
>  =20
>   		outl_p(0x30, AB_INDX(addr));
>   		outl_p(0x40, AB_DATA(addr));
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
