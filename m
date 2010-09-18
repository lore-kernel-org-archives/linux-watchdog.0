Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:17926 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab0IRPN7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Sep 2010 11:13:59 -0400
Received: from mail48-tx2 (localhost.localdomain [127.0.0.1])	by
 mail48-tx2-R.bigfish.com (Postfix) with ESMTP id DC38A11181EC	for
 <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010 15:13:57 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.240])	by
 mail48-tx2.bigfish.com (Postfix) with ESMTP id 6F25656804E	for
 <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010 15:13:52 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id o8IFDEKk004078	for
 <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010 08:13:24 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 o8IFSWdW024295	for <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010
 10:28:32 -0500 (CDT)
References: <1284764008-19469-1-git-send-email-timur@freescale.com> <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com> <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com> <1284779678.30449.108.camel@pasglop>
Message-ID: <AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
In-Reply-To: <1284779678.30449.108.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0 (iPad Mail 7B405)
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can reference it
Date: Sat, 18 Sep 2010 09:36:51 -0500
CC: "Josh Boyer" <jwboyer@gmail.com>, <linuxppc-dev@ozlabs.org>,
	<kumar.gala@freescale.com>, <linux-watchdog@vger.kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sep 17, 2010, at 10:14 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
>> I don't see any reason to limit it to GPL drivers.  Not only that, but
>> then we'll have this:
> 
> I do

Can you elaborate on that, or are you just going to pull rank on me?

> 
>> EXPORT_SYMBOL(ppc_proc_freq);
>> EXPORT_SYMBOL_GPL(ppc_tb_freq);
>> 
>> That just looks dumb. 
> 
> Right, so send a patch to fix the first one too :-)

Then why doesn't someone post a patch to change all EXPORT_SYMBOL to EXPORT_SYMBOL_GPL?  And why do we consider EXPORT_SYMBOL to be "broken"?

I'm not trying to be a troll, but I see a lot of inconsistency with respect to  EXPORT_SYMBOL and EXPORT_SYMBOL_GPL.  
> 

