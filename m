Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38283 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0IRRqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Sep 2010 13:46:23 -0400
Received: by wyf22 with SMTP id 22so3241620wyf.19
        for <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010 10:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
Date: Sat, 18 Sep 2010 13:46:21 -0400
Message-ID: <AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
From: Josh Boyer <jwboyer@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Sep 18, 2010 at 1:36 PM, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> Josh Boyer wrote:
>> It is not, in my opinion, about what is technically possible and what
>> isn't.  The kernel is licensed under the GPL.  This is a Linux kernel
>> only symbol.  One would be hard pressed to claim they have a driver
>> that wasn't written for Linux that happens to need that symbol.  As a
>> member of the Linux kernel community, I find it important to encourage
>> the contribution of code back to the kernel, and this is one way to
>> help that.  This isn't BSD.
>
> Fine, but this goes back to my original question -- if this is how the
> community feels, then why hasn't someone posted a patch that converts all
> EXPORT_SYMBOL into EXPORT_SYMBOL_GPL?

Because of history in a lot of cases, and like all communities,
opinions vary.  I did say this was my opinion, not a mandate of some
sort.

> Either we allow non-GPL drivers, or we don't.  If we don't, then we need to
> eliminate EXPORT_SYMBOL once and for all.  Otherwise, the message is
> hypocritical.

I'd be all for it.  I don't think it is as black and white as that
though, as nothing rarely is.  (we can't even get all the code to
adhere to the < 80 column "rule" ).  I also don't think it is
necessarily hypocritical.  This is a new symbol being exported, not
one that has been exported for years.

josh
