Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbbHJGKV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Aug 2015 02:10:21 -0400
Date: Mon, 10 Aug 2015 11:40:17 +0530
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com
Subject: Query: consistent method for identifying watchdog driver
Message-ID: <20150810061017.GC4523@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Watchdog Folks,

I need some way to identify the driver/module for a given watchdog node say
/dev/watchdog0.

Documentation/watchdog/watchdog-api.txt says:
identity                a string identifying the watchdog driver

However, all the watchdog driver does not define identity as DRV_NAME.

Otherway, could be to look for /sys/class/watchdog/watchdog0/device/modalias.

However, for all wd devices(say drivers/misc/mei/wd.c) we do not see an entry
for /sys/class/watchdog/watchdog0/device/. Reason is that parent of
watchdog_device has not been assigned for such devices. I will send fixup for
all such watchdog devices anyway. But, I wanted to know that what could be the
best way to identify the driver.

Thanks for your help.

~Pratyush
