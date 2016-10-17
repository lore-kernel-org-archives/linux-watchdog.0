Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp486.redcondor.net ([208.80.204.86]:54858 "EHLO
        smtp486.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbcJQJnB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Oct 2016 05:43:01 -0400
Received: from astoria.ccjclearline.com ([64.235.106.9])
          by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
          via TCP (outbound) with ESMTPS id 20161017094259881_0486
          for <linux-watchdog@vger.kernel.org>;
          Mon, 17 Oct 2016 09:42:59 +0000
Received: from [216.191.234.70] (port=51619 helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.80)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1bw4RZ-0007WM-BX
        for linux-watchdog@vger.kernel.org; Mon, 17 Oct 2016 05:42:53 -0400
Date: Mon, 17 Oct 2016 05:41:58 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux watchdog mailing list <linux-watchdog@vger.kernel.org>
Subject: curious about a couple examples of drivers including
 <asm/watchdog.h>
Message-ID: <alpine.LFD.2.20.1610170536320.4439@ca624034.mitel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


  more nitpicking pedantry ... reading watchdog-kernel-api.txt, which
claims:

"Each watchdog timer driver that wants to use the WatchDog Timer
Driver Core must #include <linux/watchdog.h> (you would have to do
this anyway when writing a watchdog device driver)."

  except i just noticed the following -- kernel files that include
<asm/watchdog.h>:

$ grep -r "include.*asm/watchdog.h" *
arch/sh/boards/mach-hp6xx/pm.c:#include <asm/watchdog.h>
arch/sh/kernel/reboot.c:#include <asm/watchdog.h>
drivers/watchdog/shwdt.c:#include <asm/watchdog.h>
drivers/watchdog/cpwd.c:#include <asm/watchdog.h>
$

  that last file, cpwd.c, includes just:

#include <asm/watchdog.h>

  while the file shwdt.c includes *both*:

#include <linux/watchdog.h>
...
#include <asm/watchdog.h>

  i readily admit i have no idea why this is being done, or if there's
a perfectly good reason that SH needs to be treated a bit differently;
just pointing out that the claim in that Doc file is not entirely
accurate for those cases.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

