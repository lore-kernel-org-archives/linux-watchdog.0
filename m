Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:14386 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756560Ab0ICLY0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Sep 2010 07:24:26 -0400
Date: Fri, 3 Sep 2010 13:24:17 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Andrew Sharp <andy.sharp@lsi.com>
Subject: Re: [PATCH] sb_wdog: release irq and reboot notifier in error path
	and module_exit()
Message-ID: <20100903112417.GM354@infomag.iguana.be>
References: <1282382870-5820-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1282382870-5820-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Akinobu,

> irq and reboot notifier are acquired in module_init() but never released.
> They should be released correctly, otherwise reloading the module or error
> during module_init() will cause a problem.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> Cc: Andrew Sharp <andy.sharp@lsi.com>

This will be added to linux-2.6-watchdog-next today.

Kind regards,
Wim.

