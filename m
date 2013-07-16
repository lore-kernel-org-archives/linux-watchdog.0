Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35227 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab3GPMRs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 08:17:48 -0400
Date: Tue, 16 Jul 2013 09:17:44 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716121743.GB2317@localhost>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
 <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13fe673f255.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Tue, Jul 16, 2013 at 09:48:56AM +0200, Sebastian Hesselbarth wrote:
>=20
> In the discussion about orion clocksource Russell was proposing a gener=
ic=20
> thread-safe write. That puts a single lock around all those writes. Of=20
> course, it will also blocked by totally unrelated thread-safe register=20
> accesses but should prevent us from having dozens of locks and solves t=
he=20
> symbol issue.
>=20

Thanks for the insight! I'll try to dig this suggestion in the clocksourc=
e
discussion. Do you have any plans for posting the clocksource soon?
This way I can base this series on something that's in Jason's trees...

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
