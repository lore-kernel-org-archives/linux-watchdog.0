Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47235 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaJCSEK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Oct 2014 14:04:10 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xa7D7-0033JB-KO
	for linux-watchdog@vger.kernel.org; Fri, 03 Oct 2014 18:04:09 +0000
Message-ID: <542EE515.5090305@roeck-us.net>
Date: Fri, 03 Oct 2014 11:04:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: [GIT PULL] watchdog updates for Linux 3.18 (#4)
References: <1412351372-4840-1-git-send-email-linux@roeck-us.net> <20141003174737.GH8811@spo001.leaseweb.nl>
In-Reply-To: <20141003174737.GH8811@spo001.leaseweb.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/03/2014 10:47 AM, Wim Van Sebroeck wrote:
> Hi Guenter,
>
> Let me verify tomorrow. What's allready in linux-watchdog-next (and for which I still
> need to sent out some mails tomorrow) are all the patches you also have except the patches
> that rely on the restart handler. So that's still on my todo list for this weekend.
> The first immutable branch (mfd-hwmon-leds-watchdog branch for the menf21) I have also in
> my tree. the second one I don't have yet (it's the restart handler patches).
>
> Can you sent me the url for that one also?
>
Hi Wim,

this should do:

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/restart-handler-for-v3.18

Note that this only includes the restart handler related patches
which I submitted myself; there are a few more in my watchdog-next branch.

> For the rest: thanks again for the good job!

My pleasure ...

Thanks,
Guenter

