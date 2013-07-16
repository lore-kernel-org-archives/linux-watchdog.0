Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:56422 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab3GPHtm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 03:49:42 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so116329bkc.38
        for <linux-watchdog@vger.kernel.org>; Tue, 16 Jul 2013 00:49:41 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	<linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<devicetree-discuss@lists.ozlabs.org>, <wim@iguana.be>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	<linux-arm-kernel@lists.infradead.org>
Date: Tue, 16 Jul 2013 09:48:56 +0200
Message-ID: <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
In-Reply-To: <20130716073101.GB25043@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Andrew, Thomas,

In the discussion about orion clocksource Russell was proposing a generic=
=20
thread-safe write. That puts a single lock around all those writes. Of=20
course, it will also blocked by totally unrelated thread-safe register=20
accesses but should prevent us from having dozens of locks and solves the=
=20
symbol issue.

Sebastian



On July 16, 2013 9:31:01 AM Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jul 16, 2013 at 09:20:59AM +0200, Thomas Petazzoni wrote:
> > Dear Andrew Lunn,
> > On Tue, 16 Jul 2013 08:59:52 +0200, Andrew Lunn wrote:
> > > Maybe i'm missing something here. You are making use of
> > > orion_timer_ctrl_clrset() from time-orion.c. How will this work on
> > > 370/XP which has a different clocksource driver?
> > I *think* the idea is that the Armada 370/XP driver will expose the
> > same function, so from the point of view of the watchdog driver, it
> > will just work.
>
> Hi Thomas
>
> That was what i was thinking would happen. And then i started to
> wonder how well the kernel linker deals with multiple definitions of
> the same symbol. Dove and 370/XP can end up in the same kernel. So we
> need to have both orion-timer and the 370/XP timer in the same kernel,
> so we end up with the same symbol in the kernel twice...
>
> Lets wait for Ezequiel to answer.
>
>    Andrew


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
