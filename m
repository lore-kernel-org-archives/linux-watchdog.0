Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55154 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab3EGUKE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 May 2013 16:10:04 -0400
Date: Tue, 7 May 2013 21:10:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] watchdog ->release() races
Message-ID: <20130507201001.GR25399@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

	Watchdog drivers tend to do something like that:

foo_open()
{
	if (test_and_set_bit(0, &foo_is_open))
		return -EBUSY;
	...
}

foo_write()
{
	...
	assign foo_expect_close
	...
}

foo_release()
{
	look at foo_expect_close, act accordingly
	clear_bit(0, &foo_is_open);
	foo_expect_close = 0;
}

OK, so it tries to make sure that there's only one opened struct file for
the device; fair enough, but what happens if we have
task A: open()/write()/close()
task B: open()/write()/close()
with task A losing CPU just between clear_bit() and clearing foo_expect_close?
If it regains CPU just after write() done by task B, we'll get foo_expect_close
unexpectedly cleared.

It's obviously racy; I'm not sure if we care about that race, but if we
do, there's about 80 drivers that need to be fixed...

Comments?
