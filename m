Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53636 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbKCDOn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 22:14:43 -0500
Subject: Re: [RFC PATCH 01/13] watchdog: core: add restart handler support
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446514586-31455-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <56381B03.6030201@roeck-us.net> <20151103025145.GA29120@ketchup.lan>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563826A1.2090605@roeck-us.net>
Date: Mon, 2 Nov 2015 19:14:41 -0800
MIME-Version: 1.0
In-Reply-To: <20151103025145.GA29120@ketchup.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/02/2015 06:51 PM, Vivien Didelot wrote:
> Hi Guenter,
>
> On Nov. Monday 02 (45) 06:25 PM, Guenter Roeck wrote:
>> On 11/02/2015 05:36 PM, Damien Riegel wrote:
>>> Many watchdog drivers implement the same code to register a restart
>>> handler. This patch provides a generic way to set such a function.
>>>
>>> The patch adds a new restart watchdog operation. If a restart priority
>>> greater than 0 is needed, the driver can call
>>> watchdog_set_restart_priority to set it.
>>>
>>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>>> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>>
>> Makes sense, and good idea. Unless the patch was written by Vivien,
>> the second tag should probably be a Reviewed-by: or Acked-by:, though.
>
> We wrote that together, but Damien did most of the work. So I think
> Reviewed-by: for me will indeed be most appropriate here.
>
> Also is it OK to include your Reviewed-by: tag in the v1 (given we add
> your comments) or not?
>

Hi Vivien,

For the entire series, if you address my comments, it is ok to add my
Reviewed-by:.

Couple of additional comments:
- Please describe the notifier field added to struct watchdog_device
   in Documentation/watchdog/watchdog-kernel-api.txt.
- Please include linux/notifier.h from include/linux/watchdog.h.

Thanks,
Guenter

