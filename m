Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:54888 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbaBFHZb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 02:25:31 -0500
Message-ID: <52F338EB.2070702@roeck-us.net>
Date: Wed, 05 Feb 2014 23:25:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
CC: linux-watchdog@vger.kernel.org, vasily.isaenko@oracle.com
Subject: Re: [PATCH] watchdog: w83697hf_wdt: return ENODEV if no device was
 found
References: <1390806273-8848-1-git-send-email-stanislav.kholmanskikh@oracle.com> <20140127163332.GA29882@roeck-us.net> <52F32AD8.4010108@oracle.com>
In-Reply-To: <52F32AD8.4010108@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/05/2014 10:25 PM, Stanislav Kholmanskikh wrote:
> Hi!
>
> On 01/27/2014 08:33 PM, Guenter Roeck wrote:
>> On Mon, Jan 27, 2014 at 11:04:33AM +0400, Stanislav Kholmanskikh wrote:
>>> Most WDT driver modules return ENODEV during modprobe if
>>> no valid device was found, but w83697hf_wdt returns EIO.
>>>
>>> Let w83697hf_wdt return ENODEV.
>>>
>>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Thank you.
>
> I'm a newbie here.
>
> Should I do something to move it forward (like send this to an another mail list), or just wait? :)
>

Just wait. I'll apply it to my tree and send a reminder to Wim at some point.
Usually Wim is pretty good at picking things up himself, though.

Of course, fun part in this case is that I actually submitted a patch
to remove this driver ;-). Not as bad as it sounds - reason was that
the w83627hf driver now supports the w83697hf as well, and the w83697hf
driver is thus redundant. I can understand Wim if he wants to keep
the driver around for a while, though.

Guenter

