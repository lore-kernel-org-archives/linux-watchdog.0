Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41837 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754067Ab1FSOQ4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 10:16:56 -0400
Date: Sun, 19 Jun 2011 15:19:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 7/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110619151909.1403205d@lxorguk.ukuu.org.uk>
In-Reply-To: <201106191325.17181.arnd@arndb.de>
References: <20110618172537.GH3441@infomag.iguana.be>
	<201106182107.45682.arnd@arndb.de>
	<20110619110328.39c0f5e1@lxorguk.ukuu.org.uk>
	<201106191325.17181.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > Then you'd need an additional interface to specify which watchdog as soon
> > as we support multiple watchdogs.
> 
> You can always have multiple ways of setting nowayout -- hardware requirements,
> global module option, local module option, and a new ioctl command -- but
> what is being used is then the logical OR of all of them.

An ioctl for it would make a lot of sense as watchdogs are often compiled
in so currently there isn't a good way to runtime set this.

Alan
