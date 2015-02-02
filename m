Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57860 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754284AbbBBXl1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 18:41:27 -0500
Date: Tue, 3 Feb 2015 00:41:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	Thomas Dziedzic <gostrc@gmail.com>
Subject: Re: [PATCH] watchdog: Fix omap watchdogs to enable the magic close bit
Message-ID: <20150202234126.GA17515@spo001.leaseweb.nl>
References: <20141014192518.GH4972@atomide.com> <20150105185902.GH4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150105185902.GH4081@atomide.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tony,

> * Tony Lindgren <tony@atomide.com> [141014 12:27]:
> > This allows testing the watchdog easily with distros just by
> > doing pkill -9 watchdog.
> > 
> > Reported-by: Thomas Dziedzic <gostrc@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Wim, still not seeing this applied, did you forget about this one?

I just applied it to linux-watchdog-next.
Didn't forgot about it, just didn't had the time yet.

Kind regards,
Wim.

