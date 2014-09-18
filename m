Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47653 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbaIRPc7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Sep 2014 11:32:59 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so1631925pde.13
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Sep 2014 08:32:58 -0700 (PDT)
Date: Thu, 18 Sep 2014 08:32:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: simplify definitions of
 WATCHDOG_NOWAYOUT(_INIT_STATUS)?
Message-ID: <20140918153253.GB11881@roeck-us.net>
References: <1410293911-18392-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140916154955.GI3755@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140916154955.GI3755@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 16, 2014 at 05:49:55PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Wim,
>=20
> On Tue, Sep 09, 2014 at 10:18:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > maybe it's arguable if the newly introduced way to define
> > WATCHDOG_NOWAYOUT and WATCHDOG_NOWAYOUT_INIT_STATUS is really simpl=
er.
> > But at least it's five lines shorter and makes the questionable nam=
ing
> > of cpp symbols more obvious. (Who can tell the difference between
> > the semantic of WATCHDOG_NOWAYOUT and WDOG_NO_WAY_OUT without furth=
er
> > checking?)
> Do you consider applying this patch?
>=20
At least I have it in my watchdog-next branch.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
