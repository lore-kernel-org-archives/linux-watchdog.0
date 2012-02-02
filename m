Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:60216 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab2BBULm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 15:11:42 -0500
Message-ID: <4F2AEBC5.9060308@antcom.de>
Date: Thu, 02 Feb 2012 21:02:13 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 0/4] pnx4008: convert to watchdog framework
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/02/2012 06:48 PM, Wolfram Sang wrote:
> Patch 3/4 is of special interest, because it extends the core to allow to set
> timeouts without having a dedicated callback. Since the core automatically sets
> 'timeout' in the watchdog device (and does limit checking, too), there is
> nothing else left to do for this device since it uses that value every time in
> start/ping.
> 
> Please review and consider for inclusion. Roland, if you'd like to test them,
> too, please do and donate "Tested-by" tags. Thanks!

Works for me: Applies cleanly, compiles, boots, watchdog barks
(rebooting appropriately when using /dev/watchdog).

Roland
