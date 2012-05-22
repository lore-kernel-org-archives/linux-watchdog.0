Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757318Ab2EVJgN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 May 2012 05:36:13 -0400
Message-ID: <4FBB5E0B.7050602@redhat.com>
Date: Tue, 22 May 2012 11:36:11 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: Tomas Winkler <tomas.winkler@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com> <20120514135209.GM3074@spo001.leaseweb.com> <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com> <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com> <20120517071906.GU3074@spo001.leaseweb.com> <CA+i0qc7CjyMi6GSs8aaJH-=6bWAM6JMHngTz7n02ODVcGp-p5g@mail.gmail.com> <20120521202145.GA3074@spo001.leaseweb.com>
In-Reply-To: <20120521202145.GA3074@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 05/21/2012 10:21 PM, Wim Van Sebroeck wrote:
> Hi Tomas,
>
>> Thanks for clarification.
>> BTW the patch is gone again from the tree.
>
> Patches are back but I added some small fixes:
> * watchdog_dev.h should have been watchdog_core.h
> * the file should have been using extern for the function prototypes.
> * introduce subsys_initcall instead of module_init and move that also to the core.
> * make subsys_initcall and module_exit static
> * moved device create code into watchdog_core where it belongs
> * changed busdev to parent
> * integrated Hans's documentation into the respective patches.
>
> Please have a look and test.

Thanks for all the work on merging this, I've re-reviewed the set and
tested it with my convert sch56xx watchdog to the wdog-core patchset.

Everything looks good and works as advertised :)

I've rebased my sch56xx watchdog patchset as my patch titled:
"watchdog_dev: Add support for dynamically allocated watchdog_device structs"
needed rebasing, I'll re-send it after this mail.

Regards,

Hans
