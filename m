Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:37885 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab3BRF2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Feb 2013 00:28:17 -0500
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"fabio.porcedda@gmail.com" <fabio.porcedda@gmail.com>,
	"Lin, JM" <JM.Lin@atmel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/8] watchdog/at91sam9_wdt: Convert to use the
 watchdog framework
Date: Mon, 18 Feb 2013 05:27:38 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364145F0DD11@penmbx01>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
 <1359702386-21284-4-git-send-email-wenyou.yang@atmel.com>
 <20130213231007.GE7867@spo001.leaseweb.com>
In-Reply-To: <20130213231007.GE7867@spo001.leaseweb.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Wim,

> This code not only converts the watchdog to the new framework,
> but it also adds the is_enable related code changes which should
> be a seperate patch.
>=20
> So I took your original patch and changed it to the below at91sam9_wdt
> watchdog conversion patch. Note: this is also without Fabio's timeout-s=
ec
> patch, this one needs to come after the conversion.
>=20
> Please test this patch and let me know if this works (the watchdog shou=
ld
> behave the same before as after this patch).

Sorry for so late reply due to Chinese New Year's holiday.

I applied it on the linux-watchdog trees,=20
and tested it on at91sam9m10g45ek both DT and non-DT support, at91sam9g25=
ek with DT support.

It works OK after one compilation error fixed.

> +	at91wdt_private.next_heartbeat =3D jiffies + wdd->timeout * HZ;
 +  at91wdt_private.next_heartbeat =3D jiffies + at91_wdt_dev.timeout * H=
Z;

Thank you very much.

Best Regards,
Wenyou Yang

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
