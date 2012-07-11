Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62860 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab2GKFd2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Jul 2012 01:33:28 -0400
Message-ID: <1341984796.4158.2.camel@phoenix>
Subject: Re: [PATCH RFT] watchdog: Convert orion_wdt driver to watchdog core
From: Axel Lin <axel.lin@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org,
	Sylver Bruneau <sylver.bruneau@googlemail.com>,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Jamie Lentin <jm@lentin.co.uk>, AndrewLunn <andrew@lunn.ch>,
	Mike Turquette <mturquette@linaro.org>
Date: Wed, 11 Jul 2012 13:33:16 +0800
In-Reply-To: <20120618140101.GP4799@lunn.ch>
References: <1339744964.20824.5.camel@phoenix>
	 <20120618140101.GP4799@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

=E6=96=BC =E4=B8=80=EF=BC=8C2012-06-18 =E6=96=BC 16:01 +0200=EF=BC=8CAndr=
ew Lunn =E6=8F=90=E5=88=B0=EF=BC=9A
> On Fri, Jun 15, 2012 at 03:22:44PM +0800, Axel Lin wrote:
> > Convert the orion_wdt driver to the watchdog framework API.
> >=20
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>
>=20
> Hi Axel
>=20
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Hi Wim,
This patch has been tested by Andrew Lunn.
I notice you have not (yet) picked up this patch.
Any comments?

Regards,
Axel

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
