Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35490 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750807AbaBKJrg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 04:47:36 -0500
Date: Tue, 11 Feb 2014 06:47:31 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 01/19] clocksource: orion: Use atomic access for
 shared registers
Message-ID: <20140211094730.GG3687@localhost>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F96993.9090007@linaro.org>
 <20140211083024.GA3687@localhost>
 <52F9E947.5020004@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52F9E947.5020004@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 10:11:35AM +0100, Daniel Lezcano wrote:
> On 02/11/2014 09:30 AM, Ezequiel Garcia wrote:
> > On Tue, Feb 11, 2014 at 01:06:43AM +0100, Daniel Lezcano wrote:
> >> On 02/06/2014 06:20 PM, Ezequiel Garcia wrote:
> >>> Replace the driver-specific thread-safe shared register API
> >>> by the recently introduced atomic_io_clear_set().
> >>>
> >>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>
> >>> Tested-by: Willy Tarreau <w@1wt.eu>
> >>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> >>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.co=
m>
> >>
> >> The patch looks good for me.
> >>
> >> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >
> > Daniel,
> >
> > Jason acked this patch for you to take it. Or do you prefer that we
> > merge it with the rest of the watchdog series?
>=20
> I can pick it, but doesn't the watchdog series depend on it ?
>=20

Nope. It's indepedent of it.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
