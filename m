Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60239 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3HUVWd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Aug 2013 17:22:33 -0400
Date: Wed, 21 Aug 2013 14:22:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Kukjin Kim <kgene@kernel.org>,
	'Leela Krishna Amudala' <l.krishna@samsung.com>,
	linux-samsung-soc@vger.kernel.org, dianders@chromium.org,
	jg1.han@samsung.com, t.figa@samsung.com, sachin.kamat@linaro.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3] watchdog: s3c2410_wdt: remove the global variables
Message-ID: <20130821212228.GA3136@roeck-us.net>
References: <1374569985-13576-1-git-send-email-l.krishna@samsung.com>
 <0e8301ce8842$eca72880$c5f57980$@org>
 <20130821200105.GB815@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130821200105.GB815@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 21, 2013 at 10:01:05PM +0200, Wim Van Sebroeck wrote:
> Hi All,
> 
> > Leela Krishna Amudala wrote:
> > > 
> > > This patch removes the global variables in the driver file and
> > > group them into a structure.
> > > 
> > > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> > 
> > (+ Wim Van Sebroeck)
> > 
> > Looks good to me,
> > 
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > 
> > Thanks,
> > Kukjin
> 
> Can someone sent me the (unquoted) patch so that I can review and add it?
> 

Try this:

wget "http://download.gmane.org/gmane.linux.kernel.samsung-soc/21022/21023"

Guenter
