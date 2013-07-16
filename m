Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59789 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932119Ab3GPNoj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 09:44:39 -0400
Date: Tue, 16 Jul 2013 09:44:22 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org, wim@iguana.be,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/10] Orion Watchdog fixes
Message-ID: <20130716134422.GE12062@titan.lakedaemon.net>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716065952.GA25043@lunn.ch>
 <20130716092059.237ea729@skate>
 <20130716073101.GB25043@lunn.ch>
 <20130716121432.GA2317@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130716121432.GA2317@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 16, 2013 at 09:14:33AM -0300, Ezequiel Garcia wrote:
> On the other side, I'm much interested in knowing if you are OK with
> breaking the watchdog DT compatibility. If you NACK this, then I'll
> start preparing a different watchdog driver for 370/XP, since I don't
> want to extend a driver that is a bit dirty.

Apparently there is some agreement that the bindings are still in flux
and that they need to be for a bit longer in order to hammer out
problems such as this.

Arnd and Olof both mentioned that something (a doc, and email?) is
forthcoming about marking some bindings as stable.  Whatever form that
takes, this one wouldn't get the stable marking yet. ;-)

Oh, and one more nit.  The work 'fix' triggers a whole bunch of "get on
this right away, does it need to go to stable?  Has anyone confirmed it?
Which commit caused the regression? etc."  Although I hate the word, I
think 'refactoring' is much more appropriate description for this series.

thx,

Jason.

