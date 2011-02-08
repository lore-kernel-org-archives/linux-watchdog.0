Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:26253
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752727Ab1BHQd2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Feb 2011 11:33:28 -0500
Message-ID: <4D517052.7050003@freescale.com>
Date: Tue, 8 Feb 2011 10:33:22 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <linuxppc-dev@ozlabs.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog: booke_wdt: clean up status messages
References: <1295299780-27338-1-git-send-email-timur@freescale.com> <1297040772.14982.25.camel@pasglop>
In-Reply-To: <1297040772.14982.25.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Benjamin Herrenschmidt wrote:
> If you're going to cleanup the messages, then I think displaying:
> 
> PowerPC Book-E Watchdog Timer Loaded
> booke_wdt: watchdog enabled (timeout = xxx sec)
> 
> Isn't very nice.
> 
> Lacks consistency ... you can prefix both lines the same way, or
> maybe better print only one line with all the necessary info.

Yeah, I see your point.  I'll post a v2.

-- 
Timur Tabi
Linux kernel developer at Freescale

