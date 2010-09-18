Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52331 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0IRBVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Sep 2010 21:21:07 -0400
Received: by iwn5 with SMTP id 5so2415858iwn.19
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Sep 2010 18:21:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com> <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Fri, 17 Sep 2010 20:20:31 -0500
Message-ID: <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
To: Josh Boyer <jwboyer@gmail.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 17, 2010 at 7:38 PM, Josh Boyer <jwboyer@gmail.com> wrote:

>>  unsigned long ppc_proc_freq;
>>  EXPORT_SYMBOL(ppc_proc_freq);
>>  unsigned long ppc_tb_freq;
>> +EXPORT_SYMBOL(ppc_tb_freq);
>
> EXPORT_SYMBOL_GPL probably, no?

I don't see any reason to limit it to GPL drivers.  Not only that, but
then we'll have this:

EXPORT_SYMBOL(ppc_proc_freq);
EXPORT_SYMBOL_GPL(ppc_tb_freq);

That just looks dumb.


-- 
Timur Tabi
Linux kernel developer at Freescale
