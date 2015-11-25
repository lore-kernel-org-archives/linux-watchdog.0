Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50931 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbKYR5X (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 12:57:23 -0500
Subject: Re: [PATCH v2 1/2] watchdog: core: call device_destroy before
 watchdog_dev_unregister
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
References: <1448408745-26719-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <56551ADB.3000107@roeck-us.net> <20151125170910.GA6095@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655F680.5020408@roeck-us.net>
Date: Wed, 25 Nov 2015 09:57:20 -0800
MIME-Version: 1.0
In-Reply-To: <20151125170910.GA6095@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

On 11/25/2015 09:09 AM, Damien Riegel wrote:
> On Tue, Nov 24, 2015 at 06:20:11PM -0800, Guenter Roeck wrote:
>> On 11/24/2015 03:45 PM, Damien Riegel wrote:
>>> device_create is called after watchdog_dev_register, so it makes more
>>> sense to call the cleanup functions in reverse order, ie. device_destroy
>>> before watchdog_dev_unregister.
>>>
>>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>
> On second thought, I am wondering if the proper fix would not be to call
> device_create before watchdog_dev_register. Consider the following
> scenario:
>
>    watchdog_register_device
>      __watchdog_register_device
> 	  watchdog_dev_register returns successfully, char dev is live
>        device_create fails, setting wdd->dev to an ERR_PTR
> 	  ...
> 	  meanwhile, a user opens the watchdog, hence ops->start is called.
> 	  If ops->start uses wdd->dev (to print a debug message for
> 	  instance), it will dereference an invalid pointer.
>
> Admittedly, it should be quite rare, but there is still a chance for a
> race condition here.
>
Only we should not have race conditions, and this might actually happen
if user space listens for a udev event on the character device, and device
creation is delayed for some reasons.

I think you are right, that is a problem. Back to the drawing board.

Ok, next question: Does it hurt to call device_create() first ?
That creates the sysfs entries for the driver.

If that doesn't work either, the only other idea I have would be to reject
an attempt to open the character device with -EAGAIN or similar if the
device node is not yet (or not anymore) available. Or maybe that would
be the correct approach anyway ? Or can we use some lock to synchronize
the two operations ?

Thanks,
Guenter

