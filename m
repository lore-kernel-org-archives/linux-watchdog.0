Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:41455 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756757Ab2ENNwM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 09:52:12 -0400
Date: Mon, 14 May 2012 15:52:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: hdegoede@redhat.com, linux-watchdog@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
Message-ID: <20120514135209.GM3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

> From: Alan Cox <alan@linux.intel.com>
> 
> We keep the old /dev/watchdog interface file for the first watchdog via
> miscdev. This is basically a cut and paste of the relevant interface code
> from the rtc driver layer tweaked for watchdog.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2 (by Wim):
>     1. Clean split between core and dev related stuff. 
>     2. Use ida instead of the watchdog_assign/release_id code.
>     3. Rest it's basically the code that Alan produced with some minor changes
>        with the comments that Hans made.
> V3: (by Tomas) 
>     1. Fix compilation error caused by missing include to watchdog_dev.h

Is allready in linux-watchdog-next (see commit 1761f6851b23e1cd61705c4c053decabb14f9092)

>     2. Add documentation changes to be part of this patch
>     3. Make init and exit module functions static (fixes sparse error)
>     4. Fix minor checkpatch.pl complains

Kind regards,
Wim.

