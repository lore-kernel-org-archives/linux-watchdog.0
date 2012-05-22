Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:52800 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753206Ab2EVQl0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 May 2012 12:41:26 -0400
Date: Tue, 22 May 2012 18:41:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
Message-ID: <20120522164124.GF3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com> <20120514135209.GM3074@spo001.leaseweb.com> <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com> <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com> <20120517071906.GU3074@spo001.leaseweb.com> <CA+i0qc7CjyMi6GSs8aaJH-=6bWAM6JMHngTz7n02ODVcGp-p5g@mail.gmail.com> <20120521202145.GA3074@spo001.leaseweb.com> <4FBB5E0B.7050602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FBB5E0B.7050602@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hans,

> >>Thanks for clarification.
> >>BTW the patch is gone again from the tree.
> >
> >Patches are back but I added some small fixes:
> >* watchdog_dev.h should have been watchdog_core.h
> >* the file should have been using extern for the function prototypes.
> >* introduce subsys_initcall instead of module_init and move that also to 
> >the core.
> >* make subsys_initcall and module_exit static
> >* moved device create code into watchdog_core where it belongs
> >* changed busdev to parent
> >* integrated Hans's documentation into the respective patches.
> >
> >Please have a look and test.
> 
> Thanks for all the work on merging this, I've re-reviewed the set and
> tested it with my convert sch56xx watchdog to the wdog-core patchset.
> 
> Everything looks good and works as advertised :)
> 
> I've rebased my sch56xx watchdog patchset as my patch titled:
> "watchdog_dev: Add support for dynamically allocated watchdog_device 
> structs"
> needed rebasing, I'll re-send it after this mail.

I will split your "watchdog_dev: Add support for dynamically allocated
watchdog_device structs" patch into 3 patches:
1) rewriting of wrappers (and I will add some extra code to it for
the get_timeleft ioctl).
2) locking
3) ref+unref+unregistered.

Hope to do that tonight.

Kind regards,
Wim.

