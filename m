Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:62355 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603Ab0KJHcI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Nov 2010 02:32:08 -0500
Date: Wed, 10 Nov 2010 08:32:06 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Intel SCU Watchdog Timer Driver for Moorestown and
	Medfield platforms.
Message-ID: <20101110073206.GX4046@infomag.iguana.be>
References: <20101109160145.6838.64143.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101109160145.6838.64143.stgit@localhost.localdomain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alan,

> From: Donald Johnson <donald.k.johnson@intel.com>
> 
> This submission includes:
>   - Fix to intel_scu_write() to start watchdog timer the on the
>     first write, and refresh on subsequent writes.
>     This enables Open, write, write, ... usage model.
>   - Moves boot parameter checks from intel_scu_open() to
>     intel_scu_watchdog_init(), so driver init will fail if these
>     parameters are out of bounds.
>   - Adds check for whether process waiting in wait_event_interruptible()
>     received a signal while it was waiting.
>   - Other small error handling changes.
> 
> Signed-off-by: Donald Johnson <donald.k.johnson@intel.com>
> [Fix a backwards check]
> Signed-off-by: Shuduo Sang <shuduo.sang@intel.com>
> [Printk and style clean + check loaded on a MID device]
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Will review it and add it to linux-2.6-watchdog-next in the coming 2 weeks.

Kind regards,
Wim.

