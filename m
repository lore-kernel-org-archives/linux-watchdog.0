Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:21600 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755801Ab1BWU7p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Feb 2011 15:59:45 -0500
Date: Wed, 23 Feb 2011 21:59:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: sch311x_wdt: fix printk condition
Message-ID: <20110223205944.GP3790@infomag.iguana.be>
References: <20110223202601.GH19898@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110223202601.GH19898@bicker>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Dan,

> "==" has higher precedence than "&".  Since
> if (sch311x_sio_inb(sio_config_port, 0x30) & (0x01 == 0)) is always
> false the message is never printed.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Btw, is this printk() even worth printing?

Patch will be added.
About the printk -> need to look into the data sheet for that... We might need to exit the driver or activate it or ...

Kind regards,
Wim.

