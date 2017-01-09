Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36082 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031145AbdAIRUD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 12:20:03 -0500
Date: Mon, 9 Jan 2017 09:19:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on
 i.MX35 and later
Message-ID: <20170109171959.GA7274@roeck-us.net>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 09, 2017 at 10:50:36AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this is my approach to fix the issue reported by Vladimir Zapolskiy.
> 
So ...

Unfortunately, I don't see any convergence on this issue. My take is that,
given the lack of convergence, it can't be that severe since no one feels
that it is important enough to get it fixed one way or the other to budge
from your positions.

I had the other patch in my watchdog-next branch. I'll drop it, and wait for
the two of you to agree to something. You can either agree to that something,
or try to convince Wim to accept one or the other patch set. For my part, I'll
only accept a patch or patch series which has a Signed-off: and/or Reviewed-by:
from both of you.

Maybe you can get together into a room and agree not to leave it until white
smoke comes out of the chimney. Just an idea.

Thanks,
Guenter
