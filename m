Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47637 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862Ab1ECNeK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2011 09:34:10 -0400
Date: Tue, 3 May 2011 14:35:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, jimmy.chen@moxa.com,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	wim@iguana.be
Subject: Re: [PATCH 2/2] watchdog: add support for MOXA V2100 watchdog
 driver
Message-ID: <20110503143501.2596a9ce@lxorguk.ukuu.org.uk>
In-Reply-To: <201105031451.56911.arnd@arndb.de>
References: <20110503103704.69aba5b2@lxorguk.ukuu.org.uk>
	<20110503105735.GB2497@pengutronix.de>
	<20110503121510.5bba70c5@lxorguk.ukuu.org.uk>
	<201105031451.56911.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> Another thing that might be nice here is to have one module that probes
> the superio-port and then registers a platform device that other drivers

That doesn't help. See the it87 request_muxed patches pending. Because
the port can be muxed we need to actually implement port muxing across
the super I/O devices. That's a separate and larger problem altogether
and this device will get fixed as we do the other so not a problem.

> can can bind to. Right now, you have to load the module manually and
> then check if it's there, something we no longer do for most devices.

A lot of these super I/O devices have no entirely safe autodetect, and
the same is true for it87 and many others. There isn't a nice elegant
solution really.

Alan
