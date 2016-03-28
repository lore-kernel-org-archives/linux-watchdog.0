Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59556 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbcC1SN4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 14:13:56 -0400
Date: Mon, 28 Mar 2016 11:13:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	"qca-upstream.external" <qca-upstream.external@qca.qualcomm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog
 not in timer block
Message-ID: <20160328181356.GA29820@roeck-us.net>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
 <20160325162326.GA25767@roeck-us.net>
 <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 28, 2016 at 11:55:28AM -0500, Matthew McClintock wrote:
>=20
> > On Mar 25, 2016, at 11:23 AM, Guenter Roeck <linux@roeck-us.net> wr=
ote:
> >=20
> >> -#define WDT_RST		0x38
> >> -#define WDT_EN		0x40
> >> -#define WDT_BITE_TIME	0x5C
> >> +enum wdt_reg {
> >> +	WDT_RST,
> >> +	WDT_EN,
> >> +	WDT_BITE_TIME,
> >> +};
> >> +
> >> +static const u32 reg_offset_data_apcs_tmr[] =3D {
> >> +	[WDT_RST] =3D 0x38,
> >> +	[WDT_EN] =3D 0x40,
> >> +	[WDT_BITE_TIME] =3D 0x5C,
> >> +};
> >> +
> >> +static const u32 reg_offset_data_kpss[] =3D {
> >> +	[WDT_RST] =3D 0x4,
> >> +	[WDT_EN] =3D 0x8,
> >=20
> > Does this work ? In the datasheet I have in front of me (APQ8064), =
the watchdog
> > at this address uses different bits. At address 0x40 (eg GSS_A5_APC=
S_WDT0_EN),
>=20
> 0x40 is acps_tmr, and looks fine.
>=20
> > bit 0 is the enable bit, and bit 1 enables interrupts. At address 0=
x08 (eg
> > LPASS_QDSP6SS_WDOG_UNMASKED_INT_EN), bit 0 enables interrupts and b=
it 1 is
> > undefined.
>=20
> I honestly don=E2=80=99t see anything at 0x8 for either blocks that l=
ooks like this. For the new block bit 0 is enabling and bit 1 enabled i=
nterrupts.
>=20
That is from the APQ8064 datasheet.=20

> > Or does "qcom,kpss-standalone" refer to some other watchdog ?
>=20
> APQ8064 would be the apcs_tmr block variant which is unchanged. MSM89=
16 as well as IPQ4019 would use the new kpss variant.
>=20
Unfortunately I don't have access to those datasheets.

> I went with block names I found internally here, but I will be the fi=
rst to admit I am terrible at names. The old block name for APQ was CPU=
0_ACPS_TMR (where really the watchdog is a subset of a timer block), an=
d on the IPQ4019 it=E2=80=99s called APCS_KPSS_WDT and it=E2=80=99s rea=
lly just a watchdog block.
>=20
> I kept the same driver because the register=E2=80=99s currently in us=
e were compatible. By the way, I tested this on an IPQ806x and IPQ4019 =
both new and old blocks.
>=20

The property name should probably be something like 'qcom,kpss-wdt'
(or 'qcom,kpss-watchdog' ?), possibly in addition to 'qcom,kpss-ipq4019=
-wdt'
and 'qcom,kpss-msm8916-wdt'.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
