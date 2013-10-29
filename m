Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39372 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751971Ab3J2ITr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 04:19:47 -0400
Date: Tue, 29 Oct 2013 09:19:46 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Coatti <fabio.coatti@gmail.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: iTCO multiple /dev entries
Message-ID: <20131029081946.GL19704@spo001.leaseweb.com>
References: <CADpTngUMM2hJar=bzf6cxxxTGK8_FALbs154YsmJk1_4A_bhcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADpTngUMM2hJar=bzf6cxxxTGK8_FALbs154YsmJk1_4A_bhcg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

> Hi, on some machines I'm trying to setup iTCO wdt (ivybridge/panther
> point), but I'm perplexed about the presence of three devices:
> 
> 
> kefk dev # ls -la wat*
> crw------- 1 root root  10, 130  4 ago 22.21 watchdog
> crw------- 1 root root 251,   0  4 ago 22.21 watchdog0
> crw------- 1 root root 251,   1  4 ago 22.21 watchdog1
> 
> 
> I was expecting only one, so I'm a bit confused about the difference
> between the devices and how to use it. I googled a bit without big
> success... maybe you could point me to some documentation?
> I checked also sources and kernel Documentation/, still no clues :)

with the introduction of the watchdog generic framework we allowed more
then 1 watchdog device. So you have watchdog0 till watchdog... .
In your case you have 2 devices that were detected: watchdog0 and watchdog1.
(for instance a iTCO device and a Super-I/O watchdog device).
for compatibility /dev/watchdog0 is the same as /dev/watchdog.

We indeed have real documentation about it, but the ideas are in
Documentation/watchdog/watchdog-kernel-api.txt (See the part:
	It contains following fields:
	* id: set by watchdog_register_device, id 0 is special. It has both a
	  /dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
	  /dev/watchdog miscdev. The id is set automatically when calling
	  watchdog_register_device.

Kind regards,
Wim.

