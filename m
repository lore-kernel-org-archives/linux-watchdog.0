Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109Ab2EKJ6V (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 05:58:21 -0400
Message-ID: <4FACE2B7.1010503@redhat.com>
Date: Fri, 11 May 2012 11:58:15 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com> <20120510192023.GA31117@spo001.leaseweb.com>
In-Reply-To: <20120510192023.GA31117@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 05/10/2012 09:20 PM, Wim Van Sebroeck wrote:
> Hi Alan, Hans,
>
>>> We keep the old /dev/watchdog interface file for the first watchdog via
>>> miscdev. This is basically a cut and paste of the relevant interface code
>>> from the rtc driver layer tweaked for watchdog.
>>>
>>> Revised to fix problems noted by Hans de Goede
>>>
>>> Signed-off-by: Alan Cox<alan@linux.intel.com>
>>
>> I'm ok with the principle. Need some more thoughts about the code (meaning: that the ID assignment should imho be in the watchdog_core.c file).
>>
>> I do have one question though: why did you use your own assign_id routines and not ida_simple_get/ida_simple_remove for instance?
>
> I re-tweaked it to fit the clean split between core and dev related stuff. I also used ida instead of the watchdog_assign/release_id code.
> For the rest it's basically the code that Alan produced with some minor changes (and also with the comments that Hans made).
>
> See attached the diff (I will need to add the kernel-api documentation update still).
> Please comment and test.

I've rebased Alan's other patches (they needed some adjustments) and my own patches on top
and run the results through several tests. Everything looks good.

I'll resend the rebased patches (both Alan's other patches and mine), right after this
mail. I've also thrown in the missing documentation update.

Regards,

Hans
