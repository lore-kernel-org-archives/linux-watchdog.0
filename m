Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:34711 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab0IRPfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Sep 2010 11:35:03 -0400
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can reference it
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
Date: Sat, 18 Sep 2010 10:34:58 -0500
CC: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-ID: <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com> <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com> <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com> <1284779678.30449.108.camel@pasglop> <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


On Sep 18, 2010, at 9:36 AM, Tabi Timur-B04825 wrote:

> On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:
> 
>> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
>>> I don't see any reason to limit it to GPL drivers.  Not only that, but
>>> then we'll have this:
>> 
>> I do
> 
> Can you elaborate on that, or are you just going to pull rank on me?
> 
>> 
>>> EXPORT_SYMBOL(ppc_proc_freq);
>>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
>>> 
>>> That just looks dumb. 
>> 
>> Right, so send a patch to fix the first one too :-)

I don't think either of these should be EXPORT_SYMBOL_GPL.  Why shouldn't a binary module be allowed to know these frequencies?  My view is why preclude anyone from using this how they want.  If they want to live in the gray area so be it.  Who am I to say they shouldn't have that choice.

> Then why doesn't someone post a patch to change all EXPORT_SYMBOL to EXPORT_SYMBOL_GPL?  And why do we consider EXPORT_SYMBOL to be "broken"?
> 
> I'm not trying to be a troll, but I see a lot of inconsistency with respect to  EXPORT_SYMBOL and EXPORT_SYMBOL_GPL.  

I'm in agreement with the lack of clarity, it seems to be developer whim.

- k

