Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57208 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcCPUvK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Mar 2016 16:51:10 -0400
Date: Wed, 16 Mar 2016 21:51:05 +0100
From: rcochran@linutronix.de
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rt@linutronix.de
Subject: watchdog: octeon: missing FROZEN hot plug notifier actions
Message-ID: <20160316205105.GA14847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


In drivers/watchdog/octeon-wdt-main.c, the hot plug notifier callback,
octeon_wdt_cpu_callback, does not handle events with CPU_TASKS_FROZEN
set in the action code.

Is this on purpose?  If so, then why is it done that way?

Thanks,
Richard
