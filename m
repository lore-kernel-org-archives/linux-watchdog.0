Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbbHRFPf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 01:15:35 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 083BEABB2E
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2015 05:15:34 +0000 (UTC)
Date: Tue, 18 Aug 2015 10:45:32 +0530
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>, Don Zickus <dzickus@redhat.com>
Subject: Query: Best way to know if a watchdog is active (kicked)
Message-ID: <20150818051532.GC27149@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I am looking for the best way to know if a watchdog has been kicked and active.

I can see a way is to read timeout(WDIOC_GETTIMEOUT) and  timeleft(
WDIOC_GETTIMELEFT). If they do not match, it means that wdt is active.

But what if we tried to read timeleft just in time when watchdog daemon/or some
other application had kicked it. May be we read timeleft twice at the interval
of 1 sec.

Please let me know if there is any other alternative which could be a better way
to know if watchdog is active?  Or may be it would be good to implement an ioctl
WDIOC_ACTIVE?

Thanks

~Pratyush
