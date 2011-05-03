Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50195 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751500Ab1ECLOD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2011 07:14:03 -0400
Date: Tue, 3 May 2011 12:15:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: jimmy.chen@moxa.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 2/2] watchdog: add support for MOXA V2100 watchdog
 driver
Message-ID: <20110503121510.5bba70c5@lxorguk.ukuu.org.uk>
In-Reply-To: <20110503105735.GB2497@pengutronix.de>
References: <20110503103704.69aba5b2@lxorguk.ukuu.org.uk>
	<ECB3782BB8F03341905DD923270296115F720B@mhqms01.moxa.com>
	<20110503105735.GB2497@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Hmm, code in a header? Can't this go into the main source? Hmm, at least
> it87_wdt.c has something very similar. Maybe it can even be shared? What
> about locking BTW?

The spinlock handles it if you look at the caller points, because you
have to own the super I/O and select it each time.


Ultimately it wants to be using request_muxed_* but that isn't in any of
the mainstream code yet so can be done in the future when the mux patches
go in.

Alan
