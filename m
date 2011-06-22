Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from exprod7og101.obsmtp.com ([64.18.2.155]:33758 "EHLO
	exprod7og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541Ab1FVUzF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 16:55:05 -0400
Message-ID: <4E023455.8010606@genband.com>
Date: Wed, 22 Jun 2011 12:28:37 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/10 v2] Generic Watchdog Timer Driver
References: <20110618171946.GB3441@infomag.iguana.be>
In-Reply-To: <20110618171946.GB3441@infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/18/2011 11:19 AM, Wim Van Sebroeck wrote:
> watchdog: WatchDog Timer Driver Core - Part 1
>
> The WatchDog Timer Driver Core is a framework
> that contains the common code for all watchdog-driver's.
> It also introduces a watchdog device structure and the
> operations that go with it.
>
> This is the introduction of this framework. This part
> supports the minimal watchdog userspace API (or with
> other words: the functionality to use /dev/watchdog's
> open, release and write functionality as defined in
> the simplest watchdog API). Extra functionality will
> follow in the next set of patches.


Have you thought about callback support for systems that support a 
two-stage watchdog?  That way we could do something useful (preserve 
system memory using kdump, for instance) rather than just getting 
whacked by the hardware.

Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
