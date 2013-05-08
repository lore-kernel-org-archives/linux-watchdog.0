Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm16-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.166]:27088
	"EHLO nm16-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752725Ab3EHAaY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 May 2013 20:30:24 -0400
Date: Tue, 7 May 2013 17:30:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] watchdog ->release() races
Message-ID: <20130508003027.GA8103@roeck-us.net>
References: <20130507201001.GR25399@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130507201001.GR25399@ZenIV.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 07, 2013 at 09:10:01PM +0100, Al Viro wrote:
> 	Watchdog drivers tend to do something like that:
> 
> foo_open()
> {
> 	if (test_and_set_bit(0, &foo_is_open))
> 		return -EBUSY;
> 	...
> }
> 
> foo_write()
> {
> 	...
> 	assign foo_expect_close
> 	...
> }
> 
> foo_release()
> {
> 	look at foo_expect_close, act accordingly
> 	clear_bit(0, &foo_is_open);
> 	foo_expect_close = 0;
> }
> 
> OK, so it tries to make sure that there's only one opened struct file for
> the device; fair enough, but what happens if we have
> task A: open()/write()/close()
> task B: open()/write()/close()
> with task A losing CPU just between clear_bit() and clearing foo_expect_close?
> If it regains CPU just after write() done by task B, we'll get foo_expect_close
> unexpectedly cleared.
> 
> It's obviously racy; I'm not sure if we care about that race, but if we
> do, there's about 80 drivers that need to be fixed...
> 
> Comments?

Good catch.

Unless I am missing something, the problem should be fixed for drivers using
the watchdog infrastructure. Might be a good incentive to convert the remaining
drivers.

There is a race in watchdog_register_device which I think is a bit more serious.
See https://patchwork.kernel.org/patch/2400801/.

It is in linux-next, so Linus should get it from Wim's pull request.

Guenter
