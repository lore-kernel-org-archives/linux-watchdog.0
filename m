Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm3.access.bullet.mail.sp2.yahoo.com ([98.139.44.130]:37884
	"EHLO nm3.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758570Ab3D3B6f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 21:58:35 -0400
Date: Mon, 29 Apr 2013 18:58:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 3/7] watchdog: mv64x60_wdt: use devm_ioremap()
Message-ID: <20130430015836.GB25984@roeck-us.net>
References: <000d01ce44bc$da891380$8f9b3a80$@samsung.com>
 <20130429175507.GC5183@roeck-us.net>
 <000501ce4545$f43495f0$dc9dc1d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501ce4545$f43495f0$dc9dc1d0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 30, 2013 at 10:56:39AM +0900, Jingoo Han wrote:
> On Tuesday, April 30, 2013 2:55 AM, Guenter Roeck wrote:
> > On Mon, Apr 29, 2013 at 06:35:15PM +0900, Jingoo Han wrote:
> > > Use devm_ioremap() to make cleanup paths simpler.
> > >
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > 
> > This patch also addresses the missing call to iounmap() if the call
> > to misc_register fails.
> 
> When devm_ioremap() is used, there is no need to call devm_iounmap().
> 
> It is because, these resource managed functions such as
> devm_ioremap() allow the driver core to automatically
> clean up any allocation, when probe function fails.
> 
Same response as before. Please read my note above. It says clearly
"this patch _addresses_ ...", not "this patch _creates_ ...".

Guenter
