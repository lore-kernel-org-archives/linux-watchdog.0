Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46639 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165Ab0IRDOy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Sep 2010 23:14:54 -0400
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Cc: Josh Boyer <jwboyer@gmail.com>, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
In-Reply-To: <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	 <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	 <AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Sep 2010 13:14:38 +1000
Message-ID: <1284779678.30449.108.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 2010-09-17 at 20:20 -0500, Timur Tabi wrote:
> I don't see any reason to limit it to GPL drivers.  Not only that, but
> then we'll have this:

I do

> EXPORT_SYMBOL(ppc_proc_freq);
> EXPORT_SYMBOL_GPL(ppc_tb_freq);
> 
> That just looks dumb. 

Right, so send a patch to fix the first one too :-)

Cheers,
Ben.


