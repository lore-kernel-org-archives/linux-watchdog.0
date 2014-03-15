Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33933 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbaCOIhZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 04:37:25 -0400
Date: Sat, 15 Mar 2014 09:37:11 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140315083711.GA11070@spo001.leaseweb.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com> <20140303104042.GU607@lukather> <20140311205405.GA10228@spo001.leaseweb.com> <20140312091649.GU2815@lukather> <20140312180751.GC1484@spo001.leaseweb.com> <20140313111558.GH2815@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140313111558.GH2815@lukather>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Maxime,

> 
> On Wed, Mar 12, 2014 at 07:07:51PM +0100, Wim Van Sebroeck wrote:
> > > > I'm OK with the patches, but what is the preferred way to get them upstream?
> > > > via watchdog tree or via arch/soc tree?
> > > 
> > > Since it touches the machine restart code, I'd prefer to merge it
> > > myself if it's ok?
> > 
> > No Problem. You have my Acked-by.
> 
> Actually, I only have to keep together patches 2 and 3. Could you
> merge the first one? I'll handle the two others.

First one added to linux-watchdog-next.

Kind regards,
Wim.

