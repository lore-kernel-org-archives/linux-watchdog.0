Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:36417 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1AGSra (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Jan 2011 13:47:30 -0500
Received: by wwi17 with SMTP id 17so736554wwi.1
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Jan 2011 10:47:29 -0800 (PST)
Date: Fri, 7 Jan 2011 18:47:22 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Iles <jamie@jamieiles.com>,
	viresh kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110107184722.GI2844@pulham.picochip.com>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
 <AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com>
 <20110107165250.GU31708@n2100.arm.linux.org.uk>
 <20110107175613.GH2844@pulham.picochip.com>
 <20110107180924.GV31708@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110107180924.GV31708@n2100.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 07, 2011 at 06:09:24PM +0000, Russell King - ARM Linux wrote:
> Probably, though I don't think aaec2000 is maintained anymore (I think it
> was a dump-and-run thing) so should probably be deleted from the kernel
> tree.
> 
> netx - since December 2008, it's only received updates when other stuff
> has changed (eg, on my clocksource sweep, or when I've noticed it no
> longer building.)  So I think that's also a candidate for deletion
> unless someone speaks up.
> 
> Wonder if anyone wants to volunteer to delete them... ;)

I'm happy to do that for aaec2000, patch to follow.  I'm willing to do
the same for netx too or would you like to give people chance to shout
first?

Jamie
