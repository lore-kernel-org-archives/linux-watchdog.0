Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab2EWIr1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 May 2012 04:47:27 -0400
Message-ID: <4FBCA418.5070203@redhat.com>
Date: Wed, 23 May 2012 10:47:20 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Tomas Winkler <tomas.winkler@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com> <20120514135209.GM3074@spo001.leaseweb.com> <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com> <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com> <20120517071906.GU3074@spo001.leaseweb.com> <CA+i0qc7CjyMi6GSs8aaJH-=6bWAM6JMHngTz7n02ODVcGp-p5g@mail.gmail.com> <20120521202145.GA3074@spo001.leaseweb.com> <4FBB5E0B.7050602@redhat.com> <20120522164124.GF3074@spo001.leaseweb.com> <4FBBC428.4010400@redhat.com> <20120522211832.GG3074@spo001.leaseweb.com>
In-Reply-To: <20120522211832.GG3074@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 05/22/2012 11:18 PM, Wim Van Sebroeck wrote:
> Hi Hans,
>
>>> I will split your "watchdog_dev: Add support for dynamically allocated
>>> watchdog_device structs" patch into 3 patches:
>>> 1) rewriting of wrappers (and I will add some extra code to it for
>>> the get_timeleft ioctl).
>>> 2) locking
>>> 3) ref+unref+unregistered.
>>
>> Sounds good! Assuming you manage to finish this tonight, I'll review
>> and test first thing tomorrow morning.
>
> They are there.

Thanks!

I've reviewed the entire set, it looks good. I like the 3-way split you did!

I've ofcourse also tested it and it works as advertised.

Regards,

Hans
