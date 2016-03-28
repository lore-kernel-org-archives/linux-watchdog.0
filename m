Return-path: <mmcclint@codeaurora.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog not in timer block
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160325162326.GA25767@roeck-us.net>
Date: Mon, 28 Mar 2016 11:55:28 -0500
Cc: andy.gross@linaro.org,
 linux-arm-msm@vger.kernel.org,
 "qca-upstream.external" <qca-upstream.external@qca.qualcomm.com>,
 Wim Van Sebroeck <wim@iguana.be>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org> <20160325162326.GA25767@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>


> On Mar 25, 2016, at 11:23 AM, Guenter Roeck <linux@roeck-us.net> =
wrote:
>=20
>> -#define WDT_RST		0x38
>> -#define WDT_EN		0x40
>> -#define WDT_BITE_TIME	0x5C
>> +enum wdt_reg {
>> +	WDT_RST,
>> +	WDT_EN,
>> +	WDT_BITE_TIME,
>> +};
>> +
>> +static const u32 reg_offset_data_apcs_tmr[] =3D {
>> +	[WDT_RST] =3D 0x38,
>> +	[WDT_EN] =3D 0x40,
>> +	[WDT_BITE_TIME] =3D 0x5C,
>> +};
>> +
>> +static const u32 reg_offset_data_kpss[] =3D {
>> +	[WDT_RST] =3D 0x4,
>> +	[WDT_EN] =3D 0x8,
>=20
> Does this work ? In the datasheet I have in front of me (APQ8064), the =
watchdog
> at this address uses different bits. At address 0x40 (eg =
GSS_A5_APCS_WDT0_EN),

0x40 is acps_tmr, and looks fine.

> bit 0 is the enable bit, and bit 1 enables interrupts. At address 0x08 =
(eg
> LPASS_QDSP6SS_WDOG_UNMASKED_INT_EN), bit 0 enables interrupts and bit =
1 is
> undefined.

I honestly don=E2=80=99t see anything at 0x8 for either blocks that =
looks like this. For the new block bit 0 is enabling and bit 1 enabled =
interrupts.

> Or does "qcom,kpss-standalone" refer to some other watchdog ?

APQ8064 would be the apcs_tmr block variant which is unchanged. MSM8916 =
as well as IPQ4019 would use the new kpss variant.

I went with block names I found internally here, but I will be the first =
to admit I am terrible at names. The old block name for APQ was =
CPU0_ACPS_TMR (where really the watchdog is a subset of a timer block), =
and on the IPQ4019 it=E2=80=99s called APCS_KPSS_WDT and it=E2=80=99s =
really just a watchdog block.

I kept the same driver because the register=E2=80=99s currently in use =
were compatible. By the way, I tested this on an IPQ806x and IPQ4019 =
both new and old blocks.

Let me know if you need more details.

-M=
