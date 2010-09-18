Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:18619
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965Ab0IRSgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Sep 2010 14:36:48 -0400
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can reference it
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
Date: Sat, 18 Sep 2010 13:36:43 -0500
CC: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <B04825@freescale.com>,
	linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-ID: <3AE9EB1F-2F5A-4A56-9171-BBAB8651C76C@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com> <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com> <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com> <1284779678.30449.108.camel@pasglop> <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com> <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com> <AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
To: Josh Boyer <jwboyer@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Sep 18, 2010, at 11:56 AM, Josh Boyer wrote:

> On Sat, Sep 18, 2010 at 11:34 AM, Kumar Gala <kumar.gala@freescale.com> wrote:
>> 
>> On Sep 18, 2010, at 9:36 AM, Tabi Timur-B04825 wrote:
>> 
>>> On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
>>> 
>>>> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
>>>>> I don't see any reason to limit it to GPL drivers.  Not only that, but
>>>>> then we'll have this:
>>>> 
>>>> I do
>>> 
>>> Can you elaborate on that, or are you just going to pull rank on me?
>>> 
>>>> 
>>>>> EXPORT_SYMBOL(ppc_proc_freq);
>>>>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
>>>>> 
>>>>> That just looks dumb.
>>>> 
>>>> Right, so send a patch to fix the first one too :-)
>> 
>> I don't think either of these should be EXPORT_SYMBOL_GPL.  Why shouldn't a binary module be allowed to know these frequencies?  My view is why preclude anyone from using this how they want.  If they want to live in the gray area so be it.  Who am I to say they shouldn't have that choice.
>> 
> 
> It is not, in my opinion, about what is technically possible and what
> isn't.  The kernel is licensed under the GPL.  This is a Linux kernel
> only symbol.  One would be hard pressed to claim they have a driver
> that wasn't written for Linux that happens to need that symbol.  As a
> member of the Linux kernel community, I find it important to encourage
> the contribution of code back to the kernel, and this is one way to
> help that.  This isn't BSD.
> 
> Besides, a developer is free to export it however they wish in their
> own kernel tree.  They can deviate from mainline if they so choose.

I'll buy this argument as a reason to make both EXPORT_SYMBOL_GPL.

- k
