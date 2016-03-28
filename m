Return-path: <mmcclint@codeaurora.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog not in timer block
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160328181356.GA29820@roeck-us.net>
Date: Mon, 28 Mar 2016 15:40:58 -0500
Cc: andy.gross@linaro.org,
 linux-arm-msm@vger.kernel.org,
 "qca-upstream.external" <qca-upstream.external@qca.qualcomm.com>,
 Wim Van Sebroeck <wim@iguana.be>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <938942F3-D0ED-4BCA-9B6A-EF716A101E0C@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org> <20160325162326.GA25767@roeck-us.net> <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org> <20160328181356.GA29820@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mar 28, 2016, at 1:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>>> bit 0 is the enable bit, and bit 1 enables interrupts. At address =
0x08 (eg
>>> LPASS_QDSP6SS_WDOG_UNMASKED_INT_EN), bit 0 enables interrupts and =
bit 1 is
>>> undefined.
>>=20
>> I honestly don=E2=80=99t see anything at 0x8 for either blocks that =
looks like this. For the new block bit 0 is enabling and bit 1 enabled =
interrupts.
>>=20
> That is from the APQ8064 datasheet.=20

So taken from the timer offset 0x0208A000 I just have a generic counter =
register CPU0_APCS_GPT0_CNT at 0x8

What doc are you looking at?

-M=
