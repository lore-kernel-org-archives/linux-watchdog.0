Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53381 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbcC1WWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 18:22:04 -0400
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog not in timer block
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160328215638.GA25221@roeck-us.net>
Date: Mon, 28 Mar 2016 17:21:59 -0500
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	"qca-upstream.external" <qca-upstream.external@qca.qualcomm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Message-Id: <1942199A-A10C-4934-A194-0955EA1D40CA@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org> <20160325162326.GA25767@roeck-us.net> <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org> <20160328181356.GA29820@roeck-us.net> <938942F3-D0ED-4BCA-9B6A-EF716A101E0C@codeaurora.org> <20160328215638.GA25221@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mar 28, 2016, at 4:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>> So taken from the timer offset 0x0208A000 I just have a generic counte=
r register CPU0_APCS_GPT0_CNT at 0x8
>>=20
>> What doc are you looking at?
>>=20
> "Qualcomm Snapdragon 600 Processor APQ8064 Hardware Register Descriptio=
n"
>=20
> It is available for download from the Qualcomm web site.
>=20
> See chapter 12.10.3, "Watchdog timer registers". The register block is =
at
> 0x28882000. Registers are almost the same, except for the offset and th=
e
> definition of the bits in the enable register.
>=20
> LPASS is "Low Power Audio Subsystem". Maybe it has its own watchdog.

This block is here:

11.15 KPSS CPU0 Timer Registers (0x0208A000 CPU0_APCS_TMR_BASE)

-M--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
