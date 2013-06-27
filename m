Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51186 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab3F0WKy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Jun 2013 18:10:54 -0400
Date: Thu, 27 Jun 2013 15:05:56 -0700
From: Kevin Strasser <kevin.strasser@linux.intel.com>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Kevin Strasser <strassek@engr.orst.edu>,
	Darren Hart <dvhart@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Brunner <Michael.Brunner@kontron.com>,
	Michael Brunner <mibru@gmx.de>,
	Chris Healy <chealy@imsco-us.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dirk Hohndel <Dirk.Hohndel@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Ben Dooks <ben-linux@fluff.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] watchdog: Kontron PLD watchdog timer driver
Message-ID: <20130627220556.GB16090@wrk>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
 <1372046406-3127-1-git-send-email-kevin.strasser@linux.intel.com>
 <1372046406-3127-5-git-send-email-kevin.strasser@linux.intel.com>
 <20130627182314.GA16090@wrk>
 <20130627214705.GA26192@zurbaran>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130627214705.GA26192@zurbaran>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, Jun 27, 2013 at 11:47:05PM +0200, Samuel Ortiz wrote:
> Hi Kevin,
>=20
> On Thu, Jun 27, 2013 at 11:23:15AM -0700, Kevin Strasser wrote:
> > Hi Wim,
> >=20
> > This driver hasn't received any further feedback. Are you ready to ta=
ke it
> > into watchdog-next, or do you still need to review it?
> I applied the watchdog patch to mfd-next and got the following warning:
>=20
>  CC [M]  drivers/watchdog/kempld_wdt.o
> drivers/watchdog/kempld_wdt.c: In function =E2=80=98kempld_wdt_suspend=E2=
=80=99:
> drivers/watchdog/kempld_wdt.c:538:3: warning: passing argument 1 of
> =E2=80=98kempld_wdt_stop=E2=80=99 from incompatible pointer type [enabl=
ed by default]
> drivers/watchdog/kempld_wdt.c:313:12: note: expected =E2=80=98struct
> watchdog_device *=E2=80=99 but argument is of type =E2=80=98struct plat=
form_device *=E2=80=99
>=20
> I fixed it up, but I'd appreciate if you could double check that
> kempld_wdt_suspend() is ok.

Ah, yes you made the appropriate change. This used to be a call to=20
kempld_wdt_shutdown, which I changed to kempld_wdt_stop to avoid the
pointless redirection. Somehow I forgot to convert the argument.

Thanks,
Kevin

>=20
> Cheers,
> Samuel.
>=20
> --=20
> Intel Open Source Technology Centre
> http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
