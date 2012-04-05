Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25014 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab2DEWcf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Apr 2012 18:32:35 -0400
Date: Thu, 5 Apr 2012 18:32:31 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sylver Bruneau <sylver.bruneau@googlemail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFT v3] watchdog: Convert orion_wdt driver to watchdog
 core
Message-ID: <20120405223231.GK817@titan.lakedaemon.net>
References: <1332804040.5294.2.camel@phoenix>
 <20120331011432.GG7274@titan.lakedaemon.net>
 <CAF+7xWkuZ6q1TbWpdvwK57wGBwd_naVZsvtj0UackWWFcam7qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAF+7xWkuZ6q1TbWpdvwK57wGBwd_naVZsvtj0UackWWFcam7qw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 01, 2012 at 06:02:30PM +0800, Axel Lin wrote:
> 2012/3/31 Jason Cooper <jason@lakedaemon.net>:
> > On Tue, Mar 27, 2012 at 07:20:40AM +0800, Axel Lin wrote:
> >> Convert orion_wdt driver to use watchdog framework API.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >> ---
> >> Hi Jason, Andrew,
> >> I don't have this hardware handy.
> >> I'd appreciate if you can review and test this patch.
> >
> > Axel,
> >
> > Sorry for the delay, been a busy week. =A0I'm getting the following e=
rror:
> >
> > drivers/watchdog/orion_wdt.c:133:2: error: unknown field 'get_timelef=
t'
> > specified in initializer
> > drivers/watchdog/orion_wdt.c:133:2: warning: initialization from
> > incompatible pointer type
> >
> > What tag did you base this off of? =A0Are there any dependencies not =
in
> > mainline?
> I generate the patch base on linux-next tree.
> I just checked Linus' tree and this patch is appliable to Linus' tree.
> The required commit[1] is alread merged to Linus' tree now.
> Can you check it again?
> Thanks.

Ah, much better.  I rebased it against v3.4-rc1 now that it's out.
Compiles without problems.  I'll test this weekend most likely.  I don't
have my watchdog code in front of me atm.

thx,

Jason.

> [1] http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=3Dlinux-watchdog=
.git;a=3Dcommitdiff;h=3Dfd7b673c92731fc6c0b1e999adfd87b6762ee797
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
