Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53968 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbbLNGYl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Dec 2015 01:24:41 -0500
Subject: Re: [RFC/RFT PATCH] watchdog: Move watchdog device creation to
 watchdog_dev.c
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1449431501-15843-1-git-send-email-linux@roeck-us.net>
 <20151207161549.GA6030@localhost> <5665B821.7070803@roeck-us.net>
 <20151207204103.GA17174@spo001.leaseweb.nl> <20151213220243.GB4600@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <566E60A3.5010102@roeck-us.net>
Date: Sun, 13 Dec 2015 22:24:35 -0800
MIME-Version: 1.0
In-Reply-To: <20151213220243.GB4600@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/13/2015 02:02 PM, Damien Riegel wrote:
> On Mon, Dec 07, 2015 at 09:41:03PM +0100, Wim Van Sebroeck wrote:
>> Hi All,
>>
>>> On 12/07/2015 08:15 AM, Damien Riegel wrote:
>>>> On Sun, Dec 06, 2015 at 11:51:41AM -0800, Guenter Roeck wrote:
>>>>> The watchdog character device s currently created in
>>>>> watchdog_dev.c, and the watchdog device in watchdog_core.c. This
>>>>> results in cross-dependencies, as the device creation needs to
>>>>> know the watchdog character device number.
>>>>>
>>>>> On top of that, the watchdog character device is created before
>>>>> the watchdog device is created. This can result in race conditions
>>>>> if the watchdog device node is accessed before the watchdog device
>>>>> has been created.
>>>>>
>>>>> To solve the problem, move watchdog device creation into
>>>>> watchdog_dev.c, and create the watchdog device prior to creating
>>>>> its device node. Also move device class creation into
>>>>> watchdog_dev.c, since this is now the only place where the
>>>>> watchdog class is needed.
>>>>>
>>>>> Inspired by an earlier patch set from Damien Riegel.
>>>>>
>>>>> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net> --- Hi Damien,
>>>>>
>>>>> I think this approach would be a bit better. The watchdog device
>>>>> isn't really used in the watchdog core code, so it is better
>>>>> created in watchdog_dev.c. That also fits well with other pending
>>>>> changes, such as sysfs attribute support, and my attempts to move
>>>>> the ref/unref functions completely into the watchdog core. As a
>>>>> side effect, it also cleans up the error path in
>>>>> __watchdog_register_device().
>>>>>
>>>>> What do you think ?
>>>>
>>>> Hi Guenter,
>>>>
>>>> Like the idea, but I don't really get the separation. For instance,
>>>> you move watchdog_class in watchdog_dev.c but you keep watchdog_ida
>>>> in watchdog_core.c whereas it is only used for device
>>>> creation/deletion.
>>>>
>>> The class is watchdog driver internal, and it is device related, so
>>> I think it made sense to move it to watchdog_dev.c. On top of that,
>>> it will be needed there if/when we introduce sysfs attributes.
>>>
>>> The watchdog id can be determined by obtaining an id using ida, or
>>> it can be provided through the watchdog alias. The operation to get
>>> it is not device related, and it is not straightforward to obtain
>>> it, so I thought it makes sense to keep the code in watchdog_core.c.
>>>
>>> Of course a lot of it is personal preference.
>>>
>>
>> Let me go back to how I saw the design when I created the generic
>> watchdog framework: When using watchdog device drivers we need to be
>> able to support the /dev/watchdog system. I also foresaw that we
>> should have a sysfs interface and I saw the future for watchdog
>> devices that you should be able to choose between the 2 different
>> systems. You should be able to use only the /dev/watchdog interfacing,
>> but you should also be able to use both a sysfs interface and a
>> /dev/watchdog interface and it should even be possible to have only a
>> sysfs interface in certain embedded devices. So that's why I split the
>> watchdog framework over 3 files: core code, the /dev/watchdog
>> interfacing and the sysfs code. Since I want to have compiled code
>> small enough when choosing either /Dev/watchdog or sysfs or both this
>> sounded the most logical thing to do (Unless you have a single file
>> full of #ifdef-ery that becomes unreadable).
>>
>> So I do not agree to have sysfs code in watchdog_dev.c . It belongs in
>> watchdog_sysfs.c imho. If someone has a better idea, I'll be glad to
>> listen to it and see what the benefits are. But I want a clean system
>> for excluding both /dev/ (current watchdog_dev.c) and/or sysfs
>> (watchdog_sysfs.c) in the future. Off-course the current behaviour is
>> to have the /dev/ interface and have the option to add sysfs
>> attributes.
>
> I agree that keeping sysfs code separate makes sense, as someone might
> want to not use it.
>
I am not really sure about that. I don't recall a similar concern with
any other subsystem.

Anyway, sure, we can move the code to another file. Sure, we can add a
configuration option. That means we'll also need to make several functions
non-static, and possibly move some functions out of watchdog_dev.c
into yet another file. But we'll need some guidance for that and an idea
what is going to be acceptable.

> The question is: can we make the /dev/watchdog entries optional ? That
> would break the compatibility, right? Imho, it would be saner to keep
> only one way to interact with watchdogs (ie. keep /dev/watchdog as is
> and don't make it optional, and sysfs read-only and eventually
> optional). I think that question should be answered before we can decide
> how we want to split the code between watchdog_dev.c and watchdog_core.c
>

All I know for my part is that all pending structural enhancements in one
way or another depend on the assumption that the character device and the
sysfs (kernel) device both exist. I have not been able to find any code
in the kernel where cdev_add is not associated with device_create, so I
don't even know if cdev_add without device_create is even possible.
The current code in watchdog_dev.c definitely depends on watchdog->dev,
though not deeply (it uses it for some dev_ messages). If that dependency
isn't supposed to exist, we'll need to do something about it now.

We now have the sysfs changes, the changes to move "soft" timeout handling
into the kernel, multiple approaches to add pretimeout into the watchdog core,
and my attempt to solve the ref/unref mess. All of those won't be able to
proceed without knowing how to handle the cdev vs. dev problem.

Wim, we really need some guidance from you.

Thanks,
Guenter

