Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:62654 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306Ab1BUTVv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Feb 2011 14:21:51 -0500
Date: Mon, 21 Feb 2011 20:21:49 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: && versus &
Message-ID: <20110221192149.GF3790@infomag.iguana.be>
References: <201102211936.44160.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201102211936.44160.toralf.foerster@gmx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Toralf,

> Im wondering about this line in drivers/watchdog/sch311x_wdt.c:
> 
> if (sch311x_sio_inb(sio_config_port, 0x30) && 0x01 == 0)
> 
> is this intended ?

This is a typo/bug.

Patch created.

Kind regards and thanks,
Wim.

