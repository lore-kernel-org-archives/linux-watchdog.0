Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp3.ore.mailhop.org ([54.149.88.251]:34801 "EHLO
	smtp3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbBCAXY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 19:23:24 -0500
Date: Mon, 2 Feb 2015 15:40:15 -0800
From: Tony Lindgren <tony@atomide.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	Thomas Dziedzic <gostrc@gmail.com>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close
 bit
Message-ID: <20150202234015.GJ9418@atomide.com>
References: <20141014192518.GH4972@atomide.com>
 <20150105185902.GH4081@atomide.com>
 <20150202234126.GA17515@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150202234126.GA17515@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

* Wim Van Sebroeck <wim@iguana.be> [150202 15:44]:
> Hi Tony,
> 
> > * Tony Lindgren <tony@atomide.com> [141014 12:27]:
> > > This allows testing the watchdog easily with distros just by
> > > doing pkill -9 watchdog.
> > > 
> > > Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Wim, still not seeing this applied, did you forget about this one?
> 
> I just applied it to linux-watchdog-next.
> Didn't forgot about it, just didn't had the time yet.

OK thanks!

Tony
