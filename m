Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:27053 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758023Ab1FVUOF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 16:14:05 -0400
Date: Wed, 22 Jun 2011 22:13:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Mark Lord <kernel@teksavvy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110622201346.GE26745@infomag.iguana.be>
References: <20110618172537.GH3441@infomag.iguana.be> <201106182107.45682.arnd@arndb.de> <20110619110328.39c0f5e1@lxorguk.ukuu.org.uk> <201106191325.17181.arnd@arndb.de> <20110619151909.1403205d@lxorguk.ukuu.org.uk> <4DFE31DC.4080201@teksavvy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DFE31DC.4080201@teksavvy.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark,

> >>> Then you'd need an additional interface to specify which watchdog as soon
> >>> as we support multiple watchdogs.
> >>
> >> You can always have multiple ways of setting nowayout -- hardware requirements,
> >> global module option, local module option, and a new ioctl command -- but
> >> what is being used is then the logical OR of all of them.
> > 
> > An ioctl for it would make a lot of sense as watchdogs are often compiled
> > in so currently there isn't a good way to runtime set this.
> 
> I wouldn't mind a kernel parameter to enable a hardware watchdog timer at boot.
> Currently, there's a window at startup where the watchdog is not enabled,
> and the system could lock up and die in there without it being triggered.

This is another tricky thing were developers will always discuss about.
What you don't want to happen is that the watchdog reboots your system when it does
an fsck at bootup (for instance because the system rebooted by the watchdog and left
the filesystem in a dirty state...).

So it's more complex if you look at the overal system...

Kind regards,
Wim.

