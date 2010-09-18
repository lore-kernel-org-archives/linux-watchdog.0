Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41452 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0IRPwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 18 Sep 2010 11:52:05 -0400
Received: by qyk36 with SMTP id 36so1665806qyk.19
        for <linux-watchdog@vger.kernel.org>; Sat, 18 Sep 2010 08:52:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
Date: Sat, 18 Sep 2010 17:52:04 +0200
Message-ID: <AANLkTikqTaOQDTYQXWp4PuYRhWkXK8uy5+iT-AvxW+91@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
From: Vitaly Wool <vitalywool@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Tabi Timur-B04825 <B04825@freescale.com>,
	linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Sep 18, 2010 at 5:34 PM, Kumar Gala <kumar.gala@freescale.com> wrote:

> I don't think either of these should be EXPORT_SYMBOL_GPL.  Why shouldn't a binary module be allowed to know these frequencies?  My view is why preclude anyone from using this how they want.  If they want to live in the gray area so be it.  Who am I to say they shouldn't have that choice.

W00t, binary modules again... No, please. No binary modules in kernelspace.

Thanks,
   Vitaly
