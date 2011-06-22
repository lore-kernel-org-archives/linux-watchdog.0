Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:1386 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287Ab1FVI6M (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 04:58:12 -0400
Date: Wed, 22 Jun 2011 10:58:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead
	of printk()
Message-ID: <20110622085809.GS23305@infomag.iguana.be>
References: <201106151915.09729.florian@openwrt.org> <201106221024.20485.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106221024.20485.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Florian,

> On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > No changes in v1, v2 and v3
> 
> Wim, these are mostly fixes for the driver, do you prefer they get merged with the MIPS tree?

No, I had them in linux-2.6-watchdog-next since this weekend allready and was planning to sent the fixes upstream.
But I think I fotgot to e-mail about it. :-(

Kind regards,
Wim.

