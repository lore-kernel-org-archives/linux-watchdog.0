Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:36835 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751898Ab2GWKhh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Jul 2012 06:37:37 -0400
Date: Mon, 23 Jul 2012 12:37:30 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <rob.herring@calxeda.com>, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 17/25] watchdog/mpc8xxx: add a const qualifier
Message-ID: <20120723103730.GL735@spo001.leaseweb.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de> <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1343034810-3386-18-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>=20
> 	drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_probe':
> 	drivers/watchdog/mpc8xxx_wdt.c:203:11: warning: assignment discards 'c=
onst' qualifier from pointer target type [enabled by default]
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ukl: split Arnd's patch by driver and add changelog]
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
