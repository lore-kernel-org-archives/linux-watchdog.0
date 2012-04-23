Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:37012
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090Ab2DWIOn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Apr 2012 04:14:43 -0400
Subject: Watchdog settimeout causes an error condition
From: Ashish Jangam <ashish.jangam@kpitcummins.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Anthony Olech <Anthony.Olech@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 23 Apr 2012 13:40:39 +0530
Message-ID: <1335168639.11826.7.camel@dhruva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The new watchdog framework of settimeout causes an error condition for
the DA9052/53 PMIC since watchdog ping gets called upon applying the new
watchdog window and in the DA9052/53 PMIC we have a minimum time for the
watchdog window called TWDMIN. A write to the watchdog before this
elapsed time - TWDMIN - cause an error.

Can this be get fixed in the new framework?

Regards,
Ashish
  


