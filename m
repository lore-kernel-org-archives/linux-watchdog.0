Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39481 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab1LDRIN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 4 Dec 2011 12:08:13 -0500
To: Wolfram Sang <w.sang@pengutronix.de>
cc: Heiko Schocher <hs@denx.de>, linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Stefan Roese <sr@denx.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] RFC, watchdog: add generic wdt driver API
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20111204125928.GB5788@pengutronix.de>
References: <1322992423-21683-1-git-send-email-hs@denx.de> <20111204125928.GB5788@pengutronix.de>
Date: Sun, 04 Dec 2011 18:08:10 +0100
Message-Id: <20111204170810.8370625EA22@gemini.denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Dear Wolfram,

In message <20111204125928.GB5788@pengutronix.de> you wrote:
>=20
> > This patch is a port from Linux 2.4 and thought as an RFC, so comment=
s
> > are greately appreciated. First question is, has this watchdog driver
> > API a chance to go in mainline? If so, what is the direction to
> > go to push it ...
>=20
> I don't see this flying. We finally have a watchdog framework in the ke=
rnel
> which covers the long existing API used by existing drivers. If I under=
stood it
> right, this additional API needs new drivers for all the watchdogs? Als=
o, I
> didn't fully get what you are missing from the combination of the curre=
nt API
> and additional userspace-handling? (check [1] for one example, not real=
ly

Watchdog support is somethign that usually comes into play for
security-critical devices.  Doing this stuff in user space may or may
not be sufficient; for example, we've seen requirements where all
related code must be running from ROM (including all other kernel
code).

Also, the implementation submitted by Heiko allows for easy watchdog
control for kernel tasks.  I don;t see a good way to do this through
user space.

But as Heikow wrote; this is a RFC patch, and the main purpose is to
try to find out if it has a chance to go into mainline - several
earlier attempts (which go back as far as 2002 - see for example [1],
[2]) all failed with similar arguments like yours: "It's too complex,
we already have watchdog support, nobody needs this". Funny enough
that we have a number of customers who consider the existing wdt
support unsufficient for their use cases.  We've been using it on all
kinds on PPC systems, and now on ARM as well.

We will not fight for inclusion of this driver, we just wat to know if
it's worth investing efforts to get it accepted or if this is a lost
case.

[1] http://osdir.com/ml/linux.ports.ppc.embedded/2003-12/msg00188.html
[2] http://thread.gmane.org/gmane.linux.kernel/884598

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Gew=C3=B6hnlich glaubt der Mensch,  wenn er nur Worte h=C3=B6rt,  es m=C3=
=BCsse sich
dabei doch auch was denken lassen.                 -- Goethe, Faust I
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
