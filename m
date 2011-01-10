Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:43467 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753978Ab1AJN6M (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Jan 2011 08:58:12 -0500
Date: Mon, 10 Jan 2011 14:58:10 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110110135810.GN3801@infomag.iguana.be>
References: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jamie,

> +config DW_WATCHDOG
> +	tristate "Synopsys DesignWare watchdog"
> +        select WATCHDOG_NOWAYOUT

I overlooked something: If your watchdog driver cannot be stopped once it's started,
then it's best to add a comment about that in your code. Selecting the WATCHDOG_NOWAYOUT
feauture (which is overall for all drivers) is not the way to do it properly.
What you should do is add a timer that ticks the watchdog if /dev/watchdog is closed.
Examples for this functionality can be found in at91sam9_wdt.c, pika_wdt.c, ...

Sorry,
Wim.

