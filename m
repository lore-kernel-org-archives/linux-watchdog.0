Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from forward.webhostbox.net ([162.251.85.61]:58675 "EHLO
	forward.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcCQDS1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Mar 2016 23:18:27 -0400
Subject: Re: watchdog: octeon: missing FROZEN hot plug notifier actions
To: rcochran@linutronix.de, Wim Van Sebroeck <wim@iguana.be>
References: <20160316205105.GA14847@linutronix.de>
Cc: linux-watchdog@vger.kernel.org, rt@linutronix.de
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56EA21FE.6040009@roeck-us.net>
Date: Wed, 16 Mar 2016 20:18:22 -0700
MIME-Version: 1.0
In-Reply-To: <20160316205105.GA14847@linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/16/2016 01:51 PM, rcochran@linutronix.de wrote:
>
> In drivers/watchdog/octeon-wdt-main.c, the hot plug notifier callback,
> octeon_wdt_cpu_callback, does not handle events with CPU_TASKS_FROZEN
> set in the action code.
>
> Is this on purpose?  If so, then why is it done that way?
>

What do you expect it to do ?

My understanding is that CPU_TASKS_FROZEN is related to suspend/resume operations,
which are not really common for typical applications using Octeon CPUs. If they now
are, it might be worthwhile thinking about adding suspend/resume support to the driver.

Thanks,
Guenter

