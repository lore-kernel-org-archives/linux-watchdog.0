Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36554 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab1FVJB2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 05:01:28 -0400
Received: by ewy4 with SMTP id 4so167519ewy.19
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jun 2011 02:01:27 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date: Wed, 22 Jun 2011 11:05:40 +0200
Cc: linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Jamie Iles <jamie@jamieiles.com>
References: <201106151915.09729.florian@openwrt.org> <201106221024.20485.florian@openwrt.org> <20110622085809.GS23305@infomag.iguana.be>
In-Reply-To: <20110622085809.GS23305@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106221105.40343.florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Wim,

On Wednesday 22 June 2011 10:58:09 Wim Van Sebroeck wrote:
> Hi Florian,
> 
> > On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > ---
> > > No changes in v1, v2 and v3
> > 
> > Wim, these are mostly fixes for the driver, do you prefer they get merged
> > with the MIPS tree?
> 
> No, I had them in linux-2.6-watchdog-next since this weekend allready and
> was planning to sent the fixes upstream. But I think I fotgot to e-mail
> about it. :-(

No problem, thanks for the heads up.
--
Florian
