Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:32178
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753660Ab1KIQ6x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Nov 2011 11:58:53 -0500
Message-ID: <4EBAB12A.2030107@freescale.com>
Date: Wed, 9 Nov 2011 14:58:18 -0200
From: Fabio Estevam <fabio.estevam@freescale.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
CC: <linux-watchdog@vger.kernel.org>, <kernel@pengutronix.de>,
	<wim@iguana.be>
Subject: Re: [PATCH 2/2] watchdog: imx2_wdt: Disable watchdog during low-power
 modes
References: <1316456640-32650-1-git-send-email-fabio.estevam@freescale.com> <1316456640-32650-2-git-send-email-fabio.estevam@freescale.com> <20110921132710.GK1966@pengutronix.de>
In-Reply-To: <20110921132710.GK1966@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Wolfram,

On 9/21/2011 10:27 AM, Wolfram Sang wrote:
> On Mon, Sep 19, 2011 at 03:24:00PM -0300, Fabio Estevam wrote:
>> Activate WDZST so that the watchdog timer does not count during low po=
wer modes.
>=20
> Should be a user-selectable option IMHO. Changing the default behaviour
> may cause regressions.

I can=C2=B4t visualize a real system usage where the watchdog needs to be=
 active in low power mode.

Which regressions exactly are you concerned about? Which platforms?

Regards,

Fabio Estevam



--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
