Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm12-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.126]:26439
	"EHLO nm12-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758823Ab3D3B5A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 21:57:00 -0400
Date: Mon, 29 Apr 2013 18:57:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] watchdog: mtx1-wdt: use
 devm_gpio_request_one()
Message-ID: <20130430015700.GA25984@roeck-us.net>
References: <000901ce44bc$38dcfbf0$aa96f3d0$@samsung.com>
 <20130429164425.GJ23799@roeck-us.net>
 <000401ce4545$979de350$c6d9a9f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000401ce4545$979de350$c6d9a9f0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 30, 2013 at 10:54:03AM +0900, Jingoo Han wrote:
> On Tuesday, April 30, 2013 1:44 AM, Guenter Roeck wrote:
> > On Mon, Apr 29, 2013 at 06:30:43PM +0900, Jingoo Han wrote:
> > > Use devm_gpio_request_one() to make cleanup paths simpler.
> > >
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > 
> > This patch also addresses the missing gpio_free in the probe error path
> > (if the call to misc_register() fails).
> 
> When devm_gpio_request_one() is used, there is no need to call
> devm_gpio_free().
> 
> It is because, these resource managed functions such as
> devm_gpio_request_one() allow the driver core to automatically
> clean up any allocation, when probe function fails.
> 
I am well aware of this.

I said this patch _addresses_ a problem, not that it creates one.

Guenter
