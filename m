Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:64284 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab1BUTbE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Feb 2011 14:31:04 -0500
Date: Mon, 21 Feb 2011 20:31:02 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: || versus |
Message-ID: <20110221193102.GG3790@infomag.iguana.be>
References: <201102211943.41597.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201102211943.41597.toralf.foerster@gmx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Toralf,

> I found in drivers/watchdog/w83697ug_wdt.c:
> 
>  outb_p(c || 0x01, WDT_EFDR); /* set bit 0 to activate GPIO2 */

Also patch created for this.

Kind regards,
Wim.

