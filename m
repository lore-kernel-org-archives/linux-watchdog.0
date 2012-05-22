Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45863 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758192Ab2EVKxd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 May 2012 06:53:33 -0400
Received: by qcro28 with SMTP id o28so3844247qcr.19
        for <linux-watchdog@vger.kernel.org>; Tue, 22 May 2012 03:53:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120521202145.GA3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
	<20120514135209.GM3074@spo001.leaseweb.com>
	<5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com>
	<CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com>
	<20120517071906.GU3074@spo001.leaseweb.com>
	<CA+i0qc7CjyMi6GSs8aaJH-=6bWAM6JMHngTz7n02ODVcGp-p5g@mail.gmail.com>
	<20120521202145.GA3074@spo001.leaseweb.com>
Date: Tue, 22 May 2012 13:53:32 +0300
Message-ID: <CA+i0qc7dxrYr1WPDnBh134rvh=h0Q+q6bKeS2sVcg=U_LrmTKw@mail.gmail.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
From: Tomas Winkler <tomasw@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 21, 2012 at 11:21 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
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
>

I think it would be better if we stick the the development process and
and the patches are send to the mailing list for review
Anyhow I'm not able to fetch the repository today, I'm not sure yet on
what side is the problem

'linux-watchdog]$ git fetch
fatal: The remote end hung up unexpectedly
'

Thanks
Tomw
