Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41827 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754067Ab1FSOP4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 10:15:56 -0400
Date: Sun, 19 Jun 2011 15:18:11 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 9/10 v2] Generic Watchdog Timer Driver
Message-ID: <20110619151811.7b7c6310@lxorguk.ukuu.org.uk>
In-Reply-To: <201106191328.40602.arnd@arndb.de>
References: <20110618172727.GJ3441@infomag.iguana.be>
	<201106182117.49026.arnd@arndb.de>
	<20110619110141.1ac221f1@lxorguk.ukuu.org.uk>
	<201106191328.40602.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> If a driver has a different interpretation of a common command, I would
> consider that a bug, not a driver specific extension. I would also

And in the real world not every device fits the framework pefectly. It's
not necessarily about interpretation but about flexibility of
implementation.

Alan
