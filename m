Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:41386 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753884AbcCAPeq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 10:34:46 -0500
Date: Tue, 1 Mar 2016 16:34:37 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: David Miller <davem@davemloft.net>
Cc: wim.coekaerts@oracle.com, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v7] Add sun4v_wdt watchdog driver
Message-ID: <20160301153436.GA27836@spo001.leaseweb.nl>
References: <1454089178-29836-1-git-send-email-wim.coekaerts@oracle.com> <20160131.110645.985983227353861690.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160131.110645.985983227353861690.davem@davemloft.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> From: Wim Coekaerts <wim.coekaerts@oracle.com>
> Date: Fri, 29 Jan 2016 09:39:38 -0800
> 
> > This driver adds sparc hypervisor watchdog support. The default
> > timeout is 60 seconds and the range is between 1 and
> > 31536000 seconds. Both watchdog-resolution and
> > watchdog-max-timeout MD properties settings are supported.
> > 
> > Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> 
> Applied, thanks.

This also has my signed-off-by as watchdog maintainer.

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

I presume you will take this via the SUN architecture tree?

Kind regards,
Wim.
