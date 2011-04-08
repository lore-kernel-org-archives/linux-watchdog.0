Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:25267 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1DHE6K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Apr 2011 00:58:10 -0400
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id p384w7Ba030915
	for <linux-watchdog@vger.kernel.org>; Thu, 7 Apr 2011 21:58:08 -0700
Received: from ywa8 (ywa8.prod.google.com [10.192.1.8])
	by kpbe13.cbf.corp.google.com with ESMTP id p384w6Xl015867
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 7 Apr 2011 21:58:06 -0700
Received: by ywa8 with SMTP id 8so1665003ywa.37
        for <linux-watchdog@vger.kernel.org>; Thu, 07 Apr 2011 21:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110408003742.GD3942@ericsson.com>
References: <1302211560-8052-1-git-send-email-natg@google.com>
	<20110408003742.GD3942@ericsson.com>
Date: Thu, 7 Apr 2011 21:58:05 -0700
Message-ID: <BANLkTimsB9EoOVq1fojcazU4GCFyqPmF=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make all it87 drivers SMP safe.
From: Natarajan Gurumoorthy <natg@google.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,
      Comments are below

On Thu, Apr 7, 2011 at 5:37 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>
> Did you consider naming this file include/linux/it87.h as suggested ?
> I thought that was a goodd idea.
>
This does seem to be a good idea. I had some other thoughts about
where to place the
it87_lock.c file. One thought was to move the lock into the
drivers/mfd directory and
completely decouple the lock from the watchdog or the hwmon
directories. The mfd/Kconfig
would contain the IT87_LOCK.

> When you send out new versions of your patch set, it would be prudent
> to list the patch version, as well as the changes made compared to previous
I am new at this. Exactly where do you list the patch version. I put
v2 in the subject line.
The only difference between the 2 patch sets was that each of the patches has a
more verbose body section explaining the contents of the patch and
each of the sub patch
Subject line reflected what was happening in that sub patch. I also
made sure I had the
"In-Reply-To" entry in the patches.

Where in the patch do you discuss the changes made with respect to the
previous patch.

When I send out the next set of patches do I have to send out the
entire patch set marked as v3.

> versions of your patch. See Documents/SubmittingPatches, rule #2.
>
> Thanks,
> Guenter



--
Regards
Nat Gurumoorthy AB6SJ
