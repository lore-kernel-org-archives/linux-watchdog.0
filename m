Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60282 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752369Ab1FSJ71 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 05:59:27 -0400
Date: Sun, 19 Jun 2011 11:01:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 9/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110619110141.1ac221f1@lxorguk.ukuu.org.uk>
In-Reply-To: <201106182117.49026.arnd@arndb.de>
References: <20110618172727.GJ3441@infomag.iguana.be>
	<201106182117.49026.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Hmm, I'm not sure about this one. It does make the conversion
> of existing drivers easier but doesn't encourage doing a good
> job there.

It's not ultimately about conversion. A lot of watchdogs have interfaces
that are not quite generic, extra requirements and custom interfaces. The
ioctl interface is needed for that, not for conversions.

Alan
