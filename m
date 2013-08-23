Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:58774 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753605Ab3HWOe3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 Aug 2013 10:34:29 -0400
Date: Fri, 23 Aug 2013 16:34:16 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kukjin Kim <kgene@kernel.org>,
	'Leela Krishna Amudala' <l.krishna@samsung.com>,
	linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	jg1.han@samsung.com, t.figa@samsung.com, sachin.kamat@linaro.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3] watchdog: s3c2410_wdt: remove the global variables
Message-ID: <20130823143416.GA15896@spo001.leaseweb.com>
References: <1374569985-13576-1-git-send-email-l.krishna@samsung.com> <0e8301ce8842$eca72880$c5f57980$@org> <20130821200105.GB815@spo001.leaseweb.com> <20130821212228.GA3136@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130821212228.GA3136@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Thanks Guenter,

> On Wed, Aug 21, 2013 at 10:01:05PM +0200, Wim Van Sebroeck wrote:
> > Hi All,
> > 
> > > Leela Krishna Amudala wrote:
> > > > 
> > > > This patch removes the global variables in the driver file and
> > > > group them into a structure.
> > > > 
> > > > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > > 
> > > (+ Wim Van Sebroeck)
> > > 
> > > Looks good to me,
> > > 
> > > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > > 
> > > Thanks,
> > > Kukjin
> > 
> > Can someone sent me the (unquoted) patch so that I can review and add it?
> > 
> 
> Try this:
> 
> wget "http://download.gmane.org/gmane.linux.kernel.samsung-soc/21022/21023"

Downloaded it and looking at it now.

Kind regards,
Wim.

